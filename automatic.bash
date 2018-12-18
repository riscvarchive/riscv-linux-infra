#!/bin/bash

set -e
set -o pipefail

ionice -c3 nice -n10 ./regenerate.bash --branch master "$@"
ionice -c3 nice -n10 ./regenerate.bash --branch for-next "$@"
#ionice -c3 nice -n10 ./regenerate.bash --branch riscv-all "$@"
