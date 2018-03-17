#!/usr/bin/env bash

set -e

# List all installed packages:
./shell.sh pip freeze

# Just print some version info:
./shell.sh uname -a

./shell.sh python --version
./shell.sh javac -version
./shell.sh ant -version
./shell.sh node --version
./shell.sh npm --version

./shell.sh voc --version