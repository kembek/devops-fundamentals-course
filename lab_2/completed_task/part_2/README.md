`adduser <user-name>` - add a new user

`usermod -aG sudo <user-name>` - give sudo privileges

Variants for moving a generated public ssh key:

- `ssh-keygen -t ed25519 -C 'web-server-sshuser'` - generating a ssh key
  `cd ~ && mkdir .ssh && touch authorized_keys && nano authorized_keys` - creating the folder for coping/pasting a generated public ssh key into the `authorized_keys` file

- `cat ~/.ssh/<key-name>.pub | ssh username@remote_host "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"` - save the created public key into the remote server (alternative way for coping/pasting a ssh key)

`nano ~/.ssh/config` - for editing a ssh configuration in a local computer where aliases can be added

Example of an alias in the config file:

```
Host sshuser-web-server
    HostName 192.168.64.4
    PreferredAuthentications publickey
    User sshuser
    IdentityFile ~/.ssh/id_25519_sshuser_webserver
    IdentitiesOnly yes
```

`ssh sshuser-web-server` - connect to the remote OS with the alias

`sudo nano /etc/ssh/sshd_config` - for editing the ssh config
Strict configuration for `ssh`:

```
...
AllowUsers sshuser        # only these users have access to connect a server
PasswordAuthentication no # disable Authentication with login and password
PermitRootLogin no        # prevent Authentication with the root credentials
PermitEmptyPasswords no   # do not permit epmty passwords
...
```

`sudo systemctl restart sshd` - restart after applying new changes in the config file

`apt install screen` - utility for creating several (paralel) windows in the terminal

Useful keybings for using the `screen` utility:

`CTRL+A C` - create a new window
`CTRL+A N` - move into a next window
`CTRL+A |` - split the window in to column
`CTRL+A TAB` - switch between columns
`CTRL+A /` - kill windows
