from sqlalchemy import create_engine, event
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.engine import Engine
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlite3 import Connection as SQLite3Connection

CONNECTION_STRING = "sqlite:///data.db"


class DBManager:
    sqlite_fk_enforced: bool = False

    __initialized: bool = False
    __instance = None

    __engine = None
    __base = None
    __session_maker = None
    __session = None

    def __new__(cls) -> 'DBManager':
        if cls.__instance is None:
            cls.__instance = super(DBManager, cls).__new__(cls)

            cls.__instance.__engine = create_engine(CONNECTION_STRING)
            cls.__instance.__base = declarative_base(
                bind=cls.__instance.__engine)
            cls.__instance.__session_maker = sessionmaker(
                expire_on_commit=True, autoflush=True)
            cls.__instance.__initialized = True

        return cls.__instance

    def get_base(self):
        if self.__initialized is True:
            return self.__base
        else:
            raise ValueError("DatabaseManager must be initialized!")

    def create_tables(self):
        if self.__initialized is True:
            self.__base.metadata.create_all(checkfirst=True)
        else:
            raise ValueError("DatabaseManager must be initialized!")

    def get_session(self):
        if self.__initialized is True:
            if self.__session is None:
                self.__session = scoped_session(self.__session_maker)

            return self.__session
        else:
            raise ValueError("DatabaseManager must be initialized!")

    def return_session(self, session):
        session.remove()
        self.__session = None
