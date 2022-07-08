#!/bin/bash

sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
service sshd restart
ssh‐keygen –b 2048 –t rsa
ssh-copy-id 192.168.10.101
ssh-copy-id 192.168.10.102
ssh-copy-id 192.168.10.103
