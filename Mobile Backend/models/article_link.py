from datetime import datetime

from db import DBManager
from sqlalchemy import Column, Integer, String, DateTime

base = DBManager().get_base()


class ArticleLink(base):
    __tablename__ = "article_link"

    # Primary Key
    id = Column(Integer, autoincrement=True, primary_key=True)

    # Data
    url = Column(String(1000), unique=True)
    discover_date = Column(DateTime, default=datetime.now())

    def __init__(self, url: str) -> None:
        self.url = url
