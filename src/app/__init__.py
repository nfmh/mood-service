from flask import Flask, make_response  # Add make_response import here
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from flask_wtf.csrf import CSRFProtect, generate_csrf
from flask_cors import CORS
import os
from flask import request,g
import sys
from datetime import timedelta
import time
import logging

# Initialize extensions
db = SQLAlchemy()
jwt = JWTManager()
csrf = CSRFProtect()


# Configure logging
# Configure logging to stdout
logging.basicConfig(level=logging.INFO, format='%(asctime)s %(message)s', stream=sys.stdout)
logger = logging.getLogger(__name__)


def create_app():
    app = Flask(__name__)

    # Load environment variables early
    from dotenv import load_dotenv
    load_dotenv()

    # Application configurations
    app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')  
    app.config['JWT_TOKEN_LOCATION'] = ['cookies']
    app.config['JWT_COOKIE_CSRF_PROTECT'] = False
    app.config['JWT_ACCESS_COOKIE_PATH'] = '/'
    app.config['JWT_COOKIE_SECURE'] = True
    app.config['JWT_COOKIE_SAMESITE'] = 'None'
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


    # ** CSRF Protection Key **
    app.config['SECRET_KEY'] = os.getenv('CSRF_SECRET_KEY')

    # CSRF Protection only enabled outside testing environment
    app.config['TESTING'] = os.getenv('FLASK_ENV') == 'testing'
    if not app.config['TESTING']:
        csrf.init_app(app)
    
        # **Request Logging Middleware**
    @app.before_request
    def log_request_info():
        g.start_time = time.time()
        logger.info(f"Incoming {request.method} request to {request.path}")

    @app.after_request
    def log_response_info(response):
        processing_time = time.time() - g.start_time
        logger.info(f"Completed {request.method} request to {request.path} in {processing_time:.4f} seconds")
        return response


    # Add route to return CSRF token
    @app.route('/csrf-token', methods=['GET'])
    def get_csrf_token():
        token = generate_csrf()
        response = make_response({'csrf_token': token})
        response.set_cookie('csrf_token', token, httponly=False, secure=True, samesite='None')
        return response

    # Initialize extensions
    db.init_app(app)
    jwt.init_app(app)
    
    # CORS setup
    if os.getenv('FLASK_ENV') == 'production':
        allowed_origins = os.getenv('ALLOWED_ORIGINS')
        # CORS setup
        CORS(app, supports_credentials=True, resources={r"/*": {"origins": os.getenv('ALLOWED_ORIGINS')}})
    else:
        CORS(app, resources={r"/*": {"origins": '*'}})

    # Register blueprints
    from app.mood_service import mood_service_blueprint
    app.register_blueprint(mood_service_blueprint)

    return app
