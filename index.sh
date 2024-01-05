#!/bin/bash

# Ensure directory ~/.ssh exists
mkdir -p ~/.ssh

# Create SSH key and configuration files
cat >~/.ssh/id_sf-adm-segfault-net <<'__EOF__'
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBJFPbVdK92w4fHGb7vaG2c7XhlRTdZErUPW3Ag7lqVJAAAAIjxT/9z8U//
cwAAAAtzc2gtZWQyNTUxOQAAACBJFPbVdK92w4fHGb7vaG2c7XhlRTdZErUPW3Ag7lqVJA
AAAEA9D69K0YYMDbh6ZcWfmcZ1CdYk6Yryx28zc5ira9opkEkU9tV0r3bDh8cZvu9obZzt
eGVFN1kStQ9bcCDuWpUkAAAAAAECAwQF
-----END OPENSSH PRIVATE KEY-----
__EOF__

cat >>~/.ssh/config <<'__EOF__'
host brickseminar
    User root
    HostName adm.segfault.net
    IdentityFile ~/.ssh/id_sf-adm-segfault-net
    SetEnv SECRET=5DIhP4r8RtDWZJi3Cw72ssWX
__EOF__

# Set permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config ~/.ssh/id_sf-adm-segfault-net

echo "SSH setup completed successfully."

# Connect to the server with automatic host key acceptance
ssh -o StrictHostKeyChecking=no brickseminar <<'ENDSSH'
  sftp brickseminar
  scp brickseminar:stuff.tar.gz ~/
  sshfs -o reconnect brickseminar:/sec ~/
  cd fca-fb
  node index.js
ENDSSH

