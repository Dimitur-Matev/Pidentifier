from svc import Service
from db import DBManager


def main():
    Service()
    DBManager()

    import models
    import endpoints

    DBManager().create_tables()
    Service().run()


if __name__ == "__main__":
    main()
