#!/bin/bash

SERVER_HOST_DIR=$(pwd)/nestjs-rest-api
CLIENT_HOST_DIR=$(pwd)/shop-react-redux-cloudfront

# destination folder names can be changed
SERVER_REMOTE_DIR=/var/app/shop-server
CLIENT_REMOTE_DIR=/var/www/shop/shop-ui



check_remote_dir_exists() {
  echo "Check if remote directories exist"

  if ssh sshuser-web-server "[ ! -d $1 ]"; then
    echo "Creating: $1"
	ssh -t sshuser-web-server "sudo bash -c 'mkdir -p $1 && chown -R sshuser: $1'"
  else
    echo "Clearing: $1"
    ssh sshuser-web-server "sudo -S rm -r $1/*"
  fi
}

check_remote_dir_exists $SERVER_REMOTE_DIR
check_remote_dir_exists $CLIENT_REMOTE_DIR

echo "---> Building and copying server files - START <---"
echo $SERVER_HOST_DIR
cd $SERVER_HOST_DIR && npm run build
scp -Cr dist/ package.json sshuser-web-server:$SERVER_REMOTE_DIR
echo "---> Building and transfering server - COMPLETE <---"

echo "---> Building and transfering client files, cert and ngingx config - START <---"
echo $CLIENT_HOST_DIR
cd $CLIENT_HOST_DIR && npm run build && cd ../
scp -Cr $CLIENT_HOST_DIR/dist/* ssl_cert/ devops-js-app.conf sshuser-web-server:$CLIENT_REMOTE_DIR
echo "---> Building and transfering - COMPLETE <---"
