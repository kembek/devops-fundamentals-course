`sudo ufw enable` - turn on firewall
`sudo ufw allow 80/tcp` - open the 80 port for TCP protocol
`sudo ufw allow 20/tcp` - open the 22 port for TCP protocol
`sudo ufw reload` - reload the firewall
`sudo ufw app list` - to see application profiles
`sudo ufw allow <profile-name>` - register a profile (setting preset), exp: `sudo ufw allow 'Nginx Full'`

`ping 192.168.64.4 -c3` - test conection to be ensure that the server is accessible
