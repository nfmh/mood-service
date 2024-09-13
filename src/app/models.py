from app import db

MOODS_ID = "moods.id"

class Mood(db.Model):
    __tablename__ = 'moods'
    id = db.Column(db.Integer, primary_key=True)
    mood_name = db.Column(db.String(50), nullable=False, unique=True)
    quotes = db.relationship('Quote', backref='mood', lazy=True)
    songs = db.relationship('Song', backref='mood', lazy=True)
    movements = db.relationship('Movement', backref='mood', lazy=True)

class Quote(db.Model):
    __tablename__ = 'quotes'
    id = db.Column(db.Integer, primary_key=True)
    mood_id = db.Column(db.Integer, db.ForeignKey(MOODS_ID), nullable=False)
    quote = db.Column(db.Text, nullable=False)

class Song(db.Model):
    __tablename__ = 'songs'
    id = db.Column(db.Integer, primary_key=True)
    mood_id = db.Column(db.Integer, db.ForeignKey(MOODS_ID), nullable=False)
    title = db.Column(db.String(255), nullable=False)
    url = db.Column(db.Text, nullable=False)

class Movement(db.Model):
    __tablename__ = 'movements'
    id = db.Column(db.Integer, primary_key=True)
    mood_id = db.Column(db.Integer, db.ForeignKey(MOODS_ID), nullable=False)
    image_url = db.Column(db.String(255), nullable=False)
