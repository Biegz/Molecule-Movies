from flask import render_template
from app import app,connection


@app.route('/')
@app.route('/index')
def index():
    with connection.cursor() as cursor:
        sql = "SELECT MovieID, Name FROM Movie WHERE `Now Playing` = 1"
        cursor.execute(sql,args=None)
        result = cursor.fetchall()

    return render_template('index.html',title = 'Home', movieData = result)



@app.route('/theaters/<id>')
def theaters(id):
    with connection.cursor() as cursor:
        sql = "SELECT Name FROM Theater,Movie_has_Theater WHERE Theater.ID = Theater_ID and Movie_MovieID = %s"
        cursor.execute(sql, (id))
        result = cursor.fetchall()
    return render_template('theaters.html',theaterData = result)



@app.route('/movies')
def movies():
    with connection.cursor() as cursor:
        sql = "SELECT MovieID, Name FROM Movie ORDER BY Name"
        cursor.execute(sql,args=None)
        result = cursor.fetchall()
    return render_template('movies.html',title = 'Home', movieData = result)



@app.route('/movies/<id>')
def movieinfo(id):
    with connection.cursor() as cursor:
        sql = "SELECT * FROM Movie WHERE Movie.MovieID = %s" 
        cursor.execute(sql,(id))
        result = cursor.fetchall()
    return render_template('moviedata.html', moreInfo = result)



@app.route('/actors')
def actors():
    with connection.cursor() as cursor:
        sql = "SELECT ID, LastName, FirstName FROM Person, Actor WHERE Person.ID = Actor.Person_ID ORDER BY LastName"
        cursor.execute(sql,args=None)
        result = cursor.fetchall()
    return render_template('actors.html',title = 'Home', actorData = result)



@app.route('/actors/<id>')
def actorinfo(id):
    with connection.cursor() as cursor:
        sql = "SELECT * FROM Person WHERE ID = %s" 
        cursor.execute(sql,(id))
        result = cursor.fetchall()
    return render_template('actordata.html', actorInfo = result)



@app.route('/toprated')
def moviescores():
    with connection.cursor() as cursor:
        sql = "SELECT MovieID, Name, RottenTomatoeScore FROM Movie ORDER BY Movie.RottenTomatoeScore desc LIMIT 5"
        cursor.execute(sql, args=None)
        result = cursor.fetchall()
    return render_template('toprated.html', topRated = result)



