from flask import Blueprint, request, jsonify, make_response
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, set_access_cookies, unset_jwt_cookies
from services.service import get_quotes, get_songs, get_movement, add_song
import secrets

mood_service_blueprint = Blueprint('mood_service', __name__)

# Routes using the service layer
@mood_service_blueprint.route('/mood', methods=['POST'])
@jwt_required()
def get_mood_info():
    data = request.get_json()

    mood_name = data.get('mood')

    if not mood_name:
        return jsonify(message="Mood is required"), 400

    # Retrieve mood quotes
    quotes = get_quotes(mood_name)
    if not quotes:
        return jsonify(message="Mood not found"), 404

    random_quote = secrets.choice(quotes).quote if quotes else "No quote available for this mood."

    # Retrieve 5 random songs, ensuring secure random sampling using secrets.SystemRandom
    # Since these songs are public data, their random sampling poses no security risk.
    songs = get_songs(mood_name)
    song_list = [{'title': song.title, 'url': song.url} for song in secrets.SystemRandom().sample(songs, min(5, len(songs)))] if songs else []

    # Retrieve mood image
    movement = get_movement(mood_name)
    image_url = movement.image_url if movement else None

    return jsonify(quote=random_quote, songs=song_list, image_url=image_url)

@mood_service_blueprint.route('/song', methods=['POST'])
@jwt_required()
def new_song():
    data = request.get_json()
    mood_name = data.get('mood')
    title = data.get('title')
    url = data.get('url')

    if not mood_name or not title or not url:
        return jsonify(message="Missing data"), 400

    new_song = add_song(title, url, mood_name)
    if not new_song:
        return jsonify(message="Mood not found"), 404

    return jsonify(message="Added new song"), 201
