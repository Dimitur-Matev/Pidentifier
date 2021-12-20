import requests

from lxml import etree
from urllib.parse import urlparse

from typing import List

from sqlalchemy.sql import base
import db
from svc import Service
from sqlalchemy.exc import IntegrityError
from flask import jsonify, make_response, request
from flask_restx import Resource, fields
from db import DBManager
from models import ArticleLink

ARTICLE_URL_XPATH = '//div[contains(@class,"news-card__title")]/a/@href'

ns = Service().get_ns()

scrape = Service().api.model('scrape_overview', {
    'url': fields.String(required=True, description='The page to spider', example="https://nltimes.nl/")
})


@ns.route('/overview')
class ScrapeOverview(Resource):

    @ns.expect(scrape, validate=True)
    def post(self):
        args = request.get_json()

        db_ses = DBManager().get_session()

        base_url = args["url"]
        article_urls = self.scrape_overview_page(base_url)
        domain = urlparse(base_url).netloc
        scheme = urlparse(base_url).scheme
        full_article_urls = self.add_base_url(f"{scheme}://{domain}", article_urls)
        add_links = []
        already_exists_count = 0

        for link in full_article_urls:
            new_article_link = ArticleLink(
                url=link
            )
            db_ses.add(new_article_link)

            try:
                db_ses.commit()
                add_links.append({
                    "id": new_article_link.id,
                    "url": new_article_link.url,
                    "discover_date": str(new_article_link.discover_date)
                })
            except IntegrityError:
                db_ses.rollback()
                already_exists_count += 1
                continue

        return make_response(jsonify({
            "add_article_links": add_links,
            "already_existed_article_links": already_exists_count
        }), 200)

    def scrape_overview_page(self, url: str) -> List[str]:
        resp = requests.get(url)
        content = resp.content.decode("UTF-8")
        tree = etree.HTML(content)
        matches = tree.xpath(ARTICLE_URL_XPATH)
        return matches

    def add_base_url(self, base_url: str, matches) -> List[str]:
        if base_url.endswith("/"):
            base_url = base_url[:-1]

        new_list = []
        for x in matches:
            new_list.append(f"{base_url}{x}")

        return new_list
