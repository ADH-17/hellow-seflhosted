#!/bin/sh

# Define installation locations
INSTALL_DIR=/usr/bin/
CONFIGURATION_INSTALL_DIR=/etc/

MAIN_PROGRAM_FILE=hellow
MAIN_CONFIG_FILE=hellow.conf

echo "Installing helloworld"

if [ "$(id -u)" -ne 0 ]; then
    echo "You ust run this script as root or with sudo"
    exit 1
fi

cp src/$MAIN_PROGRAM_FILE $INSTALL_DIR/
cp src/$MAIN_CONFIG_FILE $CONFIGURATION_INSTALL_DIR/
echo "Hello world installed successfully"