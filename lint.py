#!/usr/bin/env python3

import os
import sys
import re

# Required fields in the control file
REQUIRED_CONTROL_FIELDS = [
    "Package",
    "Version",
    "Section",
    "Priority",
    "Architecture",
    "Maintainer",
    "Description",
]

# Expected directory structure
EXPECTED_DIRS = [
    "DEBIAN",
    "usr/local/bin",
    "etc/systemd/system",
]

# Expected scripts in DEBIAN/
EXPECTED_SCRIPTS = [
    "control",
    "postinst",
    "preinst",
]

# Check if a file exists and is executable
def is_executable(file_path):
    return os.path.isfile(file_path) and os.access(file_path, os.X_OK)

# Validate the control file
def validate_control_file(control_path):
    if not os.path.isfile(control_path):
        print(f"Error: {control_path} does not exist.")
        return False

    with open(control_path, "r") as f:
        content = f.read()

    errors = []
    for field in REQUIRED_CONTROL_FIELDS:
        if f"{field}:" not in content:
            errors.append(f"Missing required field: {field}")

    if errors:
        print(f"Errors in {control_path}:")
        for error in errors:
            print(f"  - {error}")
        return False

    print(f"{control_path} is valid.")
    return True

# Validate the directory structure
def validate_directory_structure(root_dir):
    errors = []
    for dir_path in EXPECTED_DIRS:
        full_path = os.path.join(root_dir, dir_path)
        if not os.path.isdir(full_path):
            errors.append(f"Missing directory: {full_path}")

    if errors:
        print("Directory structure errors:")
        for error in errors:
            print(f"  - {error}")
        return False

    print("Directory structure is valid.")
    return True

# Validate DEBIAN scripts
def validate_debian_scripts(debian_dir):
    errors = []
    for script in EXPECTED_SCRIPTS:
        script_path = os.path.join(debian_dir, script)
        if not os.path.isfile(script_path):
            errors.append(f"Missing script: {script_path}")
        elif script != "control" and not is_executable(script_path):
            errors.append(f"Script is not executable: {script_path}")

    if errors:
        print("DEBIAN script errors:")
        for error in errors:
            print(f"  - {error}")
        return False

    print("DEBIAN scripts are valid.")
    return True

# Main linting function
def lint_project(root_dir):
    print(f"Linting project: {root_dir}")

    # Validate directory structure
    if not validate_directory_structure(root_dir):
        return False

    # Validate DEBIAN scripts
    debian_dir = os.path.join(root_dir, "DEBIAN")
    if not validate_debian_scripts(debian_dir):
        return False

    # Validate control file
    control_path = os.path.join(debian_dir, "control")
    if not validate_control_file(control_path):
        return False

    print("Linting completed successfully.")
    return True

if __name__ == "__main__":
    project_dir = os.getcwd()  # Use current directory by default
    if len(sys.argv) > 1:
        project_dir = sys.argv[1]

    if not lint_project(project_dir):
        sys.exit(1)