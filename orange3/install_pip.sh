#/bin/bash

# Install some build requirements via your system's package manager
sudo apt install virtualenv build-essential python3-dev

# Create a separate Python environment for Orange and its dependencies ...
virtualenv --python=python3 --system-site-packages orange3venv
# ... and make it the active one
source orange3venv/bin/activate

# Install Qt dependencies for the GUI
pip install PyQt5 PyQtWebEngine

# Install Orange
pip install orange3