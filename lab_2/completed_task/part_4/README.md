`apt install nginx` - installing into the server

`nginx` - run the web-server

`sudo ufw app list` - to see nginx profiles

`sudo ufw allow 'Nginx Full'` - register the nginx profile in the firewall

Nginx Important Files and Directory Locations

Below are the default locations of some of the important files and directories for Nginx

on macOS [prefix_path] = '/usr/local/' (Intel) or /opt/homebrew/ (M1 or M2)

- Nginx base web directory – [prefix_path]/var/www
- Nginx config file –[prefix_path]/etc/nginx/nginx.conf
- Log directory – [prefix_path]/var/log/nginx

on Ubuntu:

- Nginx base web directory – /var/www
- Nginx config file –/etc/nginx/nginx.conf
- Log directory – /var/log/nginx

`mkdir sites-available sites-enabled` - create folder for multiple configurations

`touch shop.conf` - create a file for a separated config

`nano shop.conf` - edit the config file

`nano /etc/nginx/nginx.conf` - for editing nginx configuration

Add a new line for including multiple configurations:

```
http {
  ...
  include /etc/nginx/sites-enabled/*;
  ...
}
```

`nginx -t` - to check correctnes of the web-server config

`nginx -s reload` - reload after changing the configuration file
