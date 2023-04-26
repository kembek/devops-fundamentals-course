`sudo npm install pm2@latest -g` - install a package for silent runnig a Node app

`pm2 start --name <process_name> <server_entrance_file.js>` - run a Node app and give a custom process name

`pm2 startup systemd` - to configure pm2 as a service

`pm2 save` - save pm2 process list

`sudo systemctl start pm2-<user_name>` - launch pm2 as a service

`systemctl status pm2-<user_name>` - check status of the servise
