#!/bin/bash

cd /usr/share/nginx/html
  
temp_file_import=$(mktemp)
temp_file=$(mktemp)
temp_file_app_version=$(mktemp)
temp_file_dynatrace=$(mktemp)
temp_file_hotjar=$(mktemp)

envsubst < "import.json" > "$temp_file_import"
envsubst < "env-prod-monolito.js" > "$temp_file"
envsubst < "env-front-version.js" > "$temp_file_app_version"
envsubst < "dynatrace.js" > "$temp_file_dynatrace"
envsubst < "hotjar.js" > "$temp_file_hotjar"


mv "$temp_file_import" "import.json"
mv "$temp_file" "env-prod-monolito.js"
mv "$temp_file_app_version" "env-front-version.js"
mv "$temp_file_dynatrace" "dynatrace.js"
mv "$temp_file_hotjar" "hotjar.js"

chmod 644 import.json
chmod 644 env-prod-monolito.js
chmod 644 env-front-version.js
chmod 644 dynatrace.js
chmod 644 hotjar.js

nginx -g 'daemon off;'