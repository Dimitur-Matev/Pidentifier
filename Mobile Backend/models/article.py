from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from db import DBManager

base = DBManager().get_base()


class Article(base):
    __tablename__ = "article"

    # ID
    id = Column(Integer, autoincrement=True, primary_key=True)

    # Foreign Key and PYTHON RELATIONSHIP
    link_id = Column(Integer, ForeignKey("article_link.id"), nullable=False)
    link = relationship("ArticleLink")

    # Extracted data from article page
    title = Column(String(1000), nullable=False)
    post_date = Column(DateTime, nullable=False)
    content = Column(Text, nullable=False)

    def __init__(self, link_id: int, title: str, post_date, content: str,) -> None:
        self.link_id = link_id
        self.title = title
        self.post_date = post_date
        self.content = content
