from flask import Flask
from flask_restx import Api


class Service(object):
    __instance = None

    app = None
    api = None
    ns = None

    def __new__(cls) -> 'Service':
        if cls.__instance is None:
            cls.__instance = super(Service, cls).__new__(cls)
            cls.__instance.init()

        return cls.__instance

    def init(self):
        self.app = Flask(__name__)
        self.api = Api(self.app,
                       version="1.0",
                       title="Mitko",
                       description="Test Description"
                       )
        self.ns = self.api.namespace('scrape', description='We scrape things')

    def get_ns(self):
        return self.ns

    def run(self):
        self.app.run(
            host="localhost",
            port=8080,
            debug=False)
