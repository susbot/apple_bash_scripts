#!/bin/bash

# DISCLAIMER
# Script install python using CURL or specific version of python if you change the version | https://www.python.org/ftp/python/
# Know the risks of installing python outside of a virtual environment!

# Download the latest version of Python 3.11.1
curl -O https://www.python.org/ftp/python/3.11.1/python-3.11.1-macos11.pkg

# Install Python
sudo installer -pkg python-3.11.1-macos11.pkg  -target /

# Clean up downloaded files
rm python-3.11.1-macos11.pkg
