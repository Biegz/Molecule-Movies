from flask import Flask
from flask_bootstrap import Bootstrap
import pymysql.cursors

app = Flask(__name__)
Bootstrap(app)

connection = pymysql.connect(host='moleculemovies.cqjtrakousir.us-east-2.rds.amazonaws.com',
                             user='moleculemovies',
                             password='tripathi',
                             db='mydb',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

from app import routes
