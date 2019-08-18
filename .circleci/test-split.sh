#!/bin/sh

target_branch='master'
CIRCLE_BRANCH='edit-service-1'

changed_files=$(git diff --name-only $target_branch..$CIRCLE_BRANCH)
echo $changed_files

# If common, models, or other files are affected, run full tests
common_models_files=$(echo $changed_files | tr ' ' '\n' | grep -oE "^src\/services\/(common|models)/" || true)
common_models_affected=$(echo $common_models_files | awk "{print length}")
others_files=$(echo $changed_files | tr ' ' '\n' | grep -v "^src\/services\/" || true)
others_affected=$(echo $others_files | awk "{print length}")
services=$(echo $changed_files | tr ' ' '\n' | grep -oE "^src\/services\/(.*)/" || true)
services_affected=$(echo $services | awk "{print length}")

if [ ${#services_affected} -gt 0 ] && [ ${#common_models_affected} -eq 0 ] && [ ${#others_affected} -eq 0 ]; then
    npm test -- $services
else
    npm test
fi