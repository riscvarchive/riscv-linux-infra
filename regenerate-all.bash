#!/bin/bash

set -e
set -o pipefail

./regenerate.bash --branch riscv-next "$@"
