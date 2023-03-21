#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
ROOT_DIR=${SCRIPT_DIR%/*}
FRONT_END_PROJECT_PATH="$ROOT_DIR/project"
FRONT_END_REP_URL="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront"

# To turn off propmt of Angular Analytics
export NG_CLI_ANALYTICS="false"

source $SCRIPT_DIR/utils.sh

deleteExistedFolderFully $FRONT_END_PROJECT_PATH

git clone "$FRONT_END_REP_URL" "$FRONT_END_PROJECT_PATH"
cd $FRONT_END_PROJECT_PATH

npm install

npm run lint
checkJobPassingSuccessfully $? "lint"

npm run test -- --watch=false
checkJobPassingSuccessfully $? "unit test"

npm run e2e
checkJobPassingSuccessfully $? "e2e test"

npm audit
checkJobPassingSuccessfully $? "audit"