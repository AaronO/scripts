#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

# Disable history
export HISTFILE=/dev/null

# Open shell in tmp folder
sh -c "exec \"${SHELL:-sh}\""
