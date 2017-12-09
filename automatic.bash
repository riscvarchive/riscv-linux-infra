#!/bin/bash

set -e
set -o pipefail

./regenerate.bash --branch master "$@"
./regenerate.bash --branch for-linux-next "$@"
./regenerate.bash --branch riscv-next "$@"
