#!/bin/bash

# Disclaimer
# Script check if Python is installed in the root directory, If python is missing it installs python specified int the python_pkg
# Know the risks of installing python outside of a virtual environment!


# Check if Python is installed
if command -v python3 &> /dev/null; then
    echo "Python is already installed."
else
    # Specify the path to the Python installer package
    python_pkg="python-3.11.1-macosx10.9.pkg"

    # Check if the Python installer package exists
    if [ -e "$python_pkg" ]; then
        # Install Python using the installer command
        sudo installer -pkg "$python_pkg" -target /
        echo "Python has been installed."
    else
        echo "Error: Python installer package not found."
    fi
fi
