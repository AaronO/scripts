#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

# Get temporary folder
tmp_folder=$(mktemp -d)

# Disable history
export HISTFILE=/dev/null

# Open shell in tmp folder
sh -c "cd ${tmp_folder}; exec \"${SHELL:-sh}\""
