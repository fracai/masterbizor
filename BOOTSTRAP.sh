#!/usr/bin/env bash

set -x

VIRTUALENV="$PWD/.venv"

python3 -m venv "$VIRTUALENV"

PATH="$VIRTUALENV/bin:$PATH"
PYTHONPATH=""

python3 -m ensurepip
pip install --upgrade wheel pip pip-review
pip install -r "REQUIREMENTS"
