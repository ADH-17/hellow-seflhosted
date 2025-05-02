#!/bin/sh
set -e -x

OUTPUT_DIR="$(pwd)"
TEMP_DIR=temp

echo "starting build"
echo "workspace: $OUTPUT_DIR"

rm -rf "$TEMP_DIR"

echo "Making directory Tree"
mkdir -p "$TEMP_DIR/DEBIAN"
mkdir -p "$TEMP_DIR/etc/systemd/system/"
mkdir -p "$TEMP_DIR/usr/local/bin"

echo "Copy control file for DEBIAN/"
cp src/DEBIAN/control "$TEMP_DIR/DEBIAN/"
cp src/DEBIAN/preinst  "$TEMP_DIR/DEBIAN/"
cp src/DEBIAN/postinst "$TEMP_DIR/DEBIAN/"

echo "Fix permissions on maintainer scripts"
chmod 755 "$TEMP_DIR/DEBIAN/preinst"
chmod 755 "$TEMP_DIR/DEBIAN/postinst"

echo "Copy binary into place"
cp src/SystemDaemon.py "$TEMP_DIR/usr/local/bin/"
cp counter.service   "$TEMP_DIR/etc/systemd/system/"

echo "Contents of $TEMP_DIR before building .deb:"
ls -R "$TEMP_DIR"

echo "Building deb file..."
dpkg-deb --root-owner-group --build "$TEMP_DIR" "$OUTPUT_DIR/hellow.deb"

echo "Contents of output dir after build:"
ls -la "$OUTPUT_DIR"

echo "Cleaning up temp directory"
rm -rf "$TEMP_DIR"

echo "Build complete: $OUTPUT_DIR/hellow.deb"
