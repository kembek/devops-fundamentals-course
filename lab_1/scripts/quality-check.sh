#!/bin/bash
ROOT_DIR="$(pwd)"
FRONT_END_PROJECT_PATH="$ROOT_DIR/project"
FRONT_END_REP_URL="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront"

# To turn off propmt of Angular Analytics
export NG_CLI_ANALYTICS="false"

source ./utils.sh

deleteExistedFolderFully $FRONT_END_PROJECT_PATH

git clone "$FRONT_END_REP_URL" "$FRONT_END_PROJECT_PATH"
cd $FRONT_END_PROJECT_PATH

npm install

npm run lint
exitIfFails $? "lint"

npm run test -- --watch=false
exitIfFails $? "unit test"

npm run e2e
exitIfFails $? "e2e test"

npm audit
exitIfFails $? "audit"