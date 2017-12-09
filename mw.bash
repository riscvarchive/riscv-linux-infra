#!/bin/bash

set -e
set -o pipefail

./regenerate.bash --branch for-mw "$@"
