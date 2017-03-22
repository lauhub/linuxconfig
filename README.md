# Debian Configuration scripts
## Introduction
This is a Debian Configuration procedure.

The scripts and procedure are inspired by [this page from Nicolargo's blog](http://blog.nicolargo.com/2013/03/mes-5-premieres-minutes-sur-un-serveur-debian.html).

## Debian configuration

### Create an user account

We will not use a root account when connecting to our system. Instead we will create a specific user, and add it to the sudoers' group.

```bash
root@server $ adduser --gecos "Morpheus",,,, morpheus
root@server $ adduser morpheus sudo
```

Once we have created it, we will login to our server using this account.

### Creating a SSH private/public key

I will not detail the creation of the key here, but only how to open the access to our user by adding the public key into its account.

First login:

```bash
ssh morpheus@server
```

Then create the `.ssh` dir and the authorized_keys file:
```bash
morpheus@server $ mkdir .ssh
morpheus@server $ nano .ssh/authorized_keys
```

Paste from the public key file you created previously into this opened file and exit `nano` using `Ctrl-o` then `Enter` (to confirm filename) then `Ctrl-x` (to exit).

Check that you SSH connection works with this private/public key pair (when logging in, the server should not ask you for your password but (eventually) for your ssh key's passphrase.

**Once you are sure it works you can proceed to next step.**

### Disable SSH access using passwords

Once you have configured your publickey access (and only when previous step was successfully tested, **unless you want to lose access to your server**), you can do the following.

```bash
morpheus@server $ sudo nano /etc/ssh/sshd_config
```

And replace the following settings with the following values:
```
PasswordAuthentication no
PermitRootLogin no
```

Then restart your ssh server:
```bash
morpheus@server $ sudo systemctl restart ssh

#Check everything works well:
morpheus@server $ sudo systemctl status ssh
```


### Setup your firewall


Using the given script, install your firewall. The best way to do this is to first clone this repository and then run the install script.

** You will need `git` and `make` to be installed**

```bash
morpheus@server $ sudo apt-get update && sudo apt-get install git make
morpheus@server $ git clone <THIS REPOS URL>
morpheus@server $ sudo make
```

#### Configuring the firewall
Edit the /etc/firewall/firewall.conf file and then test your configuration
