#!/bin/bash

ROOT_DIR="$(pwd)"
FRONT_END_PROJECT_PATH="$ROOT_DIR/project"
FRONT_END_PROJECT_DIST_PATH="$FRONT_END_PROJECT_PATH/dist/app"
FRONT_END_REP_URL="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront"
ENV_CONFIGURATION="production"
FRONT_END_ZIP_FILE_PATH="$ROOT_DIR/client-app.zip"

# To turn off propmt of Angular Analytics
export NG_CLI_ANALYTICS="false"

source ./utils.sh

deleteExistedFile $FRONT_END_ZIP_FILE_PATH
deleteExistedFolderFully $FRONT_END_PROJECT_PATH

git clone "$FRONT_END_REP_URL" "$FRONT_END_PROJECT_PATH"

cd "$FRONT_END_PROJECT_PATH"

npm install
npm run build -- --configuration="$ENV_CONFIGURATION" --progress

compressBuild $FRONT_END_ZIP_FILE_PATH $FRONT_END_PROJECT_DIST_PATH



