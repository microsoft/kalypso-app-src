# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#!/bin/bash
echo $1
echo $2
echo $3

set -euo pipefail

gen_manifests_file_name='gen_manifests.yaml'
values_file_name='values.yaml'

# Usage:
# generate-manifests.sh FOLDER_WITH_MANIFESTS FOLDER_WITH_CONFIGS GENERATED_MANIFESTS_FOLDER


mkdir -p $3

# Substitute env variables in Helm yaml files in the manifest folder
for file in `find $1 -type f \( -name "values.yaml" \)`; do envsubst <"$file" > "$file"1 && mv "$file"1 "$file"; done

# Generate manifests
helm template "$1" -f $2/$values_file_name > $3/$gen_manifests_file_name && \
cat $3/$gen_manifests_file_name
if [ $? -gt 0 ]
  then
    echo "Could not render manifests"
    exit 1
fi

cd $3 && kustomize create --autodetect
