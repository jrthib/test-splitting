#!/bin/sh

target_branch='master'
CIRCLE_BRANCH='test-splitting'

changed_files=$(git diff --name-only $target_branch..$CIRCLE_BRANCH)

# echo $changed_files | tr ' ' '\n' > changed.txt

# grep -v "^src\/services\/" changed.txt

# If common, models, or other files are affected, run full tests
common_models_affected=$(echo $changed_files | tr ' ' '\n' | grep -oE "^src\/services\/(common|models)/")
others_affected=$(echo $changed_files | tr ' ' '\n' | grep -v "^src\/services\/")

if [ -z "$common_models_affected" ] || [ -z "$others_affected" ]; then
    services_affected=$(echo $changed_files | tr ' ' '\n' | grep -oE "^src\/services\/(.*)/")
    echo $services_affected
    echo "run partial suite"
else
    echo "run full suite"
fi

