# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#!/bin/bash
echo $1
echo $2

set -euo pipefail

mkdir -p $2

# Substitute env variables
for file in `find $1 -type f \( -name "*.yml" \)`; do envsubst <"$file" > "$2/${file##*/}"; done

