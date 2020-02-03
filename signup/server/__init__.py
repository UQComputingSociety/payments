from flask import Flask
from .config import Config


app = Flask(__name__, static_folder="../gui/dist/",
            template_folder="../gui/dist/")
app.config.from_object(Config)


from signup.server import routes
