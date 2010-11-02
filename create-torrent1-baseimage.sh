#!/bin/bash

variant=minbase
#variant=buildd

bd=`cat ./env/bd`

mkdir -p "$bd"
retval="$?"

release=maverick
# natty

run_debootstrap () {

debootstrap --variant=minbase --arch amd64 "$release" "$bd" http://archive.ubuntu.com/ubuntu/
retval="$?"
if [ "$retval" != 0 ]; then
    echo debootstrap problem
    exit 1
fi

}

# run_debootstrap

cp /etc/resolv.conf "$bd"/etc/resolv.conf

apt_establish_main() {

cat > "$bd"/etc/apt/sources.list << _END_
deb http://us.archive.ubuntu.com/ubuntu/ $release main
deb-src http://us.archive.ubuntu.com/ubuntu/ $release main
deb http://us.archive.ubuntu.com/ubuntu/ $release-updates main
deb-src http://us.archive.ubuntu.com/ubuntu/ $release-updates main
_END_

}

append_universe_updates() {

cat >> "$bd"/etc/apt/sources.list << _END_
deb http://us.archive.ubuntu.com/ubuntu/ $release universe
deb-src http://us.archive.ubuntu.com/ubuntu/ $release universe
deb http://us.archive.ubuntu.com/ubuntu/ $release-updates universe
deb-src http://us.archive.ubuntu.com/ubuntu/ $release-updates universe
_END_

}

setup_apt_sources() {

if [ "$1" == "main" ]; then

    apt_establish_main

fi

if [ "$1" == "universe" ]; then

    append_universe_updates

fi

}

setup_apt_sources main

check_packages () {

chroot "$bd" apt-get -y --force-yes update

#
# I think these have to go in a certain order.
#

chroot "$bd" apt-get -y --force-yes install module-init-tools
chroot "$bd" apt-get -y --force-yes install autoconf automake libtool
chroot "$bd" apt-get -y --force-yes install wget
chroot "$bd" apt-get -y --force-yes install svtools runit net-tools
chroot "$bd" apt-get -y --force-yes install ethtool
chroot "$bd" apt-get -y --force-yes install nut # for upsmon shutting down
chroot "$bd" apt-get update
chroot "$bd" apt-get -y --force-yes install openssh-server
chroot "$bd" apt-get -y --force-yes install dhcp3-common dhcp3-client
chroot "$bd" apt-get -y --force-yes install dhcdbd
chroot "$bd" /usr/bin/dpkg --purge ppp pppoe pppconfig pppoeconf
chroot "$bd" apt-get upgrade -y
chroot "$bd" apt-get clean

chroot "$bd" apt-get -y --force-yes install pciutils # for lspci
chroot "$bd" apt-get -y --force=yes install language-pack-en # for locale error
chroot "$bd" apt-get -y --force=yes install language-support-en # needed?
chroot "$bd" apt-get -y --force-yes install lzma
chroot "$bd" apt-get -y --force-yes install smartd # for drive monitoring
chroot "$bd" apt-get -y --force-yes install ipsvd
chroot "$bd" apt-get -y --force-yes install gcc
chroot "$bd" apt-get -y --force-yes install libssl-dev # for btpd sources

chroot "$bd" apt-get -y --force-yes upgrade

}

check_packages

exit 0

#
# secondary debootstrap, not needed if your target system is identical to the one you are starting with.
#

image_work () {

echo Setting up another directory structure, just so you can extract a recent boot image, /boot/vmlinuz-

debootstrap --variant=minbase --arch amd64 "$release" "$release"-image-module http://archive.ubuntu.com/ubuntu/
retval="$?"
if [ "$retval" != 0 ]; then
    echo debootstrap problem
    exit 1
fi
cp /etc/resolv.conf "$bd"-image-module/etc/resolv.conf
cp /etc/apt/sources.list "$bd"-image-module/etc/apt/
#editor "$bd"/etc/apt/sources.list
chroot "$release"-image-module apt-get -y --force-yes install linux-image-server

}

# image_work
