#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

git_url=${1:-}

# Fail if no argument
if [ -z "${git_url}" ]; then
    echo "$0 <git_url>"
    exit 1
fi

# Get temporary folder
tmp_folder=$(mktemp -d)

# Clone git repo
git clone "${git_url}" "${tmp_folder}"

# Disable history
export HISTFILE=/dev/null

# Open shell in tmp folder
sh -c "cd ${tmp_folder}; exec \"${SHELL:-sh}\""
