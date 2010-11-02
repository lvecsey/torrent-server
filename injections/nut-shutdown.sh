#!/bin/sh

echo Sending a sync statement, so the system starts flushing stuff.

sync

echo Preparing to stop btpd service.

# stop btpd service here

touch /stop-btpd

/root/btpd-git/bin/btcli -d /mnt/torrent kill

echo Sleeping a couple seconds.

sleep 2

# umount hard drive

umount /mnt/torrent
retval="$?"

echo umount returned "$retval"

echo Sleeping for 3 seconds.

sleep 3

echo Removing storage modules.

rmmod /lib/modules/`uname -r`/drivers/ata/ahci.ko
rmmod /lib/modules/`uname -r`/drivers/ata/libahci.ko
rmmod /lib/modules/`uname -r`/drivers/scsi/st.ko

echo Sleeping another 4 seconds.

sleep 4

echo Sending shutdown in a second.

sleep 1

echo o > /proc/sysrq-trigger

