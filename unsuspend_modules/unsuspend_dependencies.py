#!/bin/bash

# Disclaimer, Bash script checks the root directory for Python | If Python is missing it uses curl to download and install the specific version.
# the script then switches to a target directory and install a virtual environment, including any packages using pip
# Know the risks of installing python outside of a virtual environment!


# Path to the target directory
target_directory=""

# Check if Python is already installed
if command -v python3 &>/dev/null; then
    echo "Python is already installed."
else
    echo "Installing Python..."
    # Download and install Python
    curl -O https://www.python.org/ftp/python/3.11.1/python-3.11.1-macosx10.9.pkg
    sudo installer -pkg python-3.11.1-macosx10.9.pkg -target /
    rm python-3.11.1-macosx10.9.pkg
    echo "Python installed successfully."
fi

# Navigate to the target directory
cd "$target_directory"

# Check if the virtual environment already exists
if [ -d "venv" ]; then
    echo "Virtual environment already exists."
else
    echo "Creating virtual environment..."
    # Create a virtual environment named 'venv'
    python3 -m venv venv
    echo "Virtual environment created successfully."
fi

# Activate the virtual environment
echo "Activating virtual environment..."
source venv/bin/activate
echo "Virtual environment activated. Installing dependencies..."

# Install required packages using pip
pip3 install requests
pip3 install google-auth
pip3 install google-api-python-client

echo "Dependencies installed successfully."

# Now you can proceed with your additional steps or scripts.

# Deactivate the virtual environment when done
# deactivate

