#!/bin/bash

set -eu

readonly output_path=${QT_PATH:-/opt/Qt}

aqt install-qt linux desktop 5.15.0 -O ${output_path}
