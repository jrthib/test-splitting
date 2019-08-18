#!/bin/sh

target_branch='master'
CIRCLE_BRANCH='edit-service-2-3'

changed_files=$(git diff --name-only $target_branch..$CIRCLE_BRANCH)

# If common, models, or other files are affected, run full tests
common_models_files=$(echo $changed_files | tr ' ' '\n' | grep -oE "^src\/services\/(common|models)/" || true)
common_models_affected=$(echo $common_models_files | awk "{print length}")
others_files=$(echo $changed_files | tr ' ' '\n' | grep -v "^src\/services\/" || true)
others_affected=$(echo $others_files | awk "{print length}")
service_files=$(echo $changed_files | tr ' ' '\n' | grep -oE "^src\/services\/(.*)/" || true)
services_affected=$(echo $service_files | awk "{print length}")

echo $service_files
echo ${#services_affected}
echo ${#common_models_affected}
echo ${#others_affected}

if [ ${#services_affected} -gt 1 ] && [ ${#common_models_affected} -eq 1 ] && [ ${#others_affected} -eq 1 ]; then
    npm test -- $service_files
else
    npm test
fi