#!/bin/sh

bd=`cat env/bd`

if [ ! -d injections ]; then
    echo Sorry, injections directory not found.
    exit 1
fi

echo Creating priv separation directory, otherwise sshd will not start.
mkdir -p "$bd"/var/run/sshd
chown root.root "$bd"/var/run/sshd

echo Copying over authorized keys files.
mkdir -p "$bd"/root/.ssh
cp injections/authorized_keys2 "$bd"/root/.ssh
chown -R root.root "$bd"/root
chmod 600 "$bd"/root/.ssh/authorized_keys2

echo You need to go in and allow root for ssh access, in /etc/ssh/sshd_config
grep PermitRoot "$bd"/etc/ssh/sshd_config
