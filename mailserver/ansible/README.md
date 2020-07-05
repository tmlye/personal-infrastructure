# Mailserver provisioning with Ansible

## User

This playbook will setup a new user called `mailuser` on the target and add `$HOME/.ssh/id_ecdsa.pub` to the authorized keys. Password and PAM login is disabled for SSH.
The user password is read from the ansible vault `group_vars/all/vault.yml`. You need to recreate this vault (see the `ansible-vault` cli tool) and update the contents to:
```
---
user_password: your_secure_password
```
