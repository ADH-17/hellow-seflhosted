#!/bin/sh

PROGNAME=hellow
INSTALL_DIR=usr/local/bin

echo "Installing $PROGNAME to $INSTALL_DIR"
cp src/$PROGNAME.py $INSTALL_DIR/$PROGNAME

chmod +x $INSTALL_DIR/$PROGNAME

echo "$PROGNAME installed Successfully"