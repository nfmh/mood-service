from app.models import Quote, Song, Movement, Mood
from app import db

def get_quotes(mood_name):
    mood = Mood.query.filter_by(mood_name=mood_name).first()
    if not mood:
        return []
    return Quote.query.filter_by(mood_id=mood.id).all()

def get_songs(mood_name):
    mood = Mood.query.filter_by(mood_name=mood_name).first()
    if not mood:
        return []
    return Song.query.filter_by(mood_id=mood.id).all()

def get_movement(mood_name):
    mood = Mood.query.filter_by(mood_name=mood_name).first()
    if not mood:
        return None
    return Movement.query.filter_by(mood_id=mood.id).first()

def add_song(title, url, mood_name):
    mood = Mood.query.filter_by(mood_name=mood_name).first()
    if not mood:
        return None
    new_song = Song(title=title, url=url, mood_id=mood.id)
    db.session.add(new_song)
    db.session.commit()
    return new_song
