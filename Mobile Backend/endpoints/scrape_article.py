import re
import string
from typing import Tuple
from datetime import datetime

import requests
from lxml import etree
from sqlalchemy import exc
from sqlalchemy.exc import IntegrityError
from flask import jsonify, make_response, request
from flask_restx import Resource, fields

from svc import Service
from db import DBManager
from models import ArticleLink, Article

ns = Service().get_ns()

scrape = Service().api.model('scrape_article', {
    "article_link_id": fields.Integer(required=True, example=1)
})

CONTENT_XPATH = '//div[@class="news-article--body"]/div/p//text()'
DATE_XPATH = '//div[@class="news-article--date"]/text()'
TITLE_XPATH = '//h1/span/text()'


@ns.route('/article')
class ScrapeArticle(Resource):

    @ns.expect(scrape, validate=True)
    def post(self):
        args = request.get_json()
        db_ses = DBManager().get_session()

        try:
            article_link = db_ses.query(
                ArticleLink).get(args["article_link_id"])
            if article_link is None:
                raise ValueError

            return_data = {
                "id": article_link.id,
                "url": article_link.url,
                "discover_date": str(article_link.discover_date)
            }

            title, date, content = self.parse_article(article_link.url)

            parsed_article = Article(
                article_link.id,
                title=title,
                post_date=date,
                content=content
            )
            db_ses.add(parsed_article)
            db_ses.commit()
            DBManager().return_session(db_ses)

            return make_response(jsonify({
                "title": title,
                "date": str(date),
                "content": content,
                "url": return_data["url"]
            }), 200)
        except IntegrityError as e:
            DBManager().return_session(db_ses)

            return make_response(jsonify({
                "ERROR": str(e)
            }), 400)
        except ValueError as e:
            print(e)
            return make_response(jsonify({
                "ERROR": f"NO FOUND WITH ID: {args['article_link_id']}"
            }), 400)

    def parse_article(self, url: str) -> Tuple[str, datetime, str]:
        # Get response and parse to XML tree object
        resp = requests.get(url)
        content = resp.content.decode("UTF-8")
        tree = etree.HTML(content)

        # Get title
        title_raw = tree.xpath(TITLE_XPATH)
        title = str(title_raw[0])

        # Get date
        date_raw = tree.xpath(DATE_XPATH)
        date = re.sub(' +', ' ', str(date_raw[0]))
        date = re.sub('\n', '', str(date))
        date = date.strip(' ')
        date = datetime.strptime(date, "%A, %B %d, %Y - %H:%M")

        # Get content
        content_raw = tree.xpath(CONTENT_XPATH)
        content_list = []
        for raw in content_raw:
            content_list.append(raw)
        content = " ".join(content_list)

        return title, date, content
