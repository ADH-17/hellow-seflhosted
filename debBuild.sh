#!/bin/sh
set -e -x  # Exit on error, print each command

OUTPUT_DIR="$(pwd)"
TEMP_DIR=temp

echo "Starting build"
echo "Workspace: $OUTPUT_DIR"

# Clean old temp directory
rm -rf "$TEMP_DIR"

# Create directory structure
echo "Making directory tree"
mkdir -p "$TEMP_DIR/DEBIAN"
mkdir -p "$TEMP_DIR/etc/systemd/system"
mkdir -p "$TEMP_DIR/usr/local/bin"

# Copy Debian control files
echo "Copying control and maintainer scripts"
cp src/DEBIAN/control "$TEMP_DIR/DEBIAN/"
cp src/DEBIAN/preinst "$TEMP_DIR/DEBIAN/"
cp src/DEBIAN/postinst "$TEMP_DIR/DEBIAN/"

# Set correct permissions
echo "Fixing permissions on DEBIAN files"
chmod 755 "$TEMP_DIR/DEBIAN"
chmod 755 "$TEMP_DIR/DEBIAN/control"
chmod 755 "$TEMP_DIR/DEBIAN/preinst"
chmod 755 "$TEMP_DIR/DEBIAN/postinst"

# Copy binary and service file
echo "Copying binary and service file"
cp hellow.py "$TEMP_DIR/usr/local/bin/SystemDaemon.py"
chmod 755 "$TEMP_DIR/usr/local/bin/SystemDaemon.py"

cp hellow.service "$TEMP_DIR/etc/systemd/system/"
chmod 644 "$TEMP_DIR/etc/systemd/system/hellow.service"

# Ensure DEBIAN dir has correct permissions (re-check, just in case)
chmod 755 "$TEMP_DIR/DEBIAN"

# Set directory permissions
chmod -R 755 "$TEMP_DIR/usr"
chmod -R 755 "$TEMP_DIR/etc"

# Show contents
echo "Verifying contents before build:"
ls -R "$TEMP_DIR"

# Build the .deb
echo "Building .deb package..."
dpkg-deb --root-owner-group --build "$TEMP_DIR" "$OUTPUT_DIR/hellow.deb"

# Show results
echo "Verifying output:"
ls -la "$OUTPUT_DIR/hellow.deb"

# Cleanup
echo "Cleaning up temp directory"
rm -rf "$TEMP_DIR"

echo "✅ Build complete: $OUTPUT_DIR/hellow.deb"
