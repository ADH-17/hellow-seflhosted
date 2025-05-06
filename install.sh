#!/bin/sh

# Define installation locations
INSTALL_DIR=/usr/bin/
CONFIGURATION_INSTALL_DIR=/etc/

MAIN_PROGRAM_FILE=hellow
MAIN_CONFIG_FILE=hellow.conf

echo "Installing helloworld..."

# Check for root/sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "You must run this script as root or with sudo."
    exit 1
fi

# Ensure source files exist
if [ ! -f "src/$MAIN_PROGRAM_FILE" ]; then
    echo "Error: src/$MAIN_PROGRAM_FILE not found."
    exit 1
fi

if [ ! -f "src/$MAIN_CONFIG_FILE" ]; then
    echo "Warning: src/$MAIN_CONFIG_FILE not found. Skipping config copy."
else
    cp "src/$MAIN_CONFIG_FILE" "$CONFIGURATION_INSTALL_DIR"
    echo "Config installed to $CONFIGURATION_INSTALL_DIR"
fi

# Copy main binary/script
cp "src/$MAIN_PROGRAM_FILE" "$INSTALL_DIR"
chmod +x "$INSTALL_DIR/$MAIN_PROGRAM_FILE"

echo "helloworld installed successfully to $INSTALL_DIR"
