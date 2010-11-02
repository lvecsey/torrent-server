#!/bin/bash

#network modules and base modules.dep

bd=`cat env/bd`

mb=`cat env/mb`

if [ ! -e "env/uname_r" ]; then
    echo kernel version not found, please configure in env/uname_r
    exit 1
fi

uname_r=`cat env/uname_r`

mkdir -p "$bd"/lib/modules/"$uname_r"
mkdir -p "$bd"/lib/modules/"$uname_r"/kernel/drivers

mkdir -p /lib/modules/"$uname_r"

precise_minimal () {

target_dir="$bd"/lib/modules/"$uname_r"/kernel/drivers/net
mkdir -p $target_dir
cp "$mb"/"$uname_r"/kernel/drivers/net/mii.ko "$target_dir"
cp "$mb"/"$uname_r"/kernel/drivers/net/r8169.ko "$target_dir"

cp "$mb"/"$uname_r"/kernel/drivers/net/sky2.ko "$target_dir"

# Broadcom
cp "$mb"/"$uname_r"/kernel/drivers/net/tg3.ko "$target_dir"

}

full_insert_net() {

cp -a "$mb"/"$uname_r"/kernel/drivers/net "$bd"/lib/modules/"$uname_r"/kernel/drivers/net

}

full_insert_net

full_insert_ata() {

cp -a "$mb"/"$uname_r"/kernel/drivers/ata "$bd"/lib/modules/"$uname_r"/kernel/drivers/ata

}

full_insert_scsi() {

cp -a "$mb"/"$uname_r"/kernel/drivers/scsi "$bd"/lib/modules/"$uname_r"/kernel/drivers/scsi

}

full_insert_ata
full_insert_scsi








