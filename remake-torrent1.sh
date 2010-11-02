#!/bin/sh

bd=`cat env/bd`

#output_img=/tftpboot/initrds/finance-server.initrd.img
#output_img=/mnt/cache/$USER/finance-server.initrd.img

if [ ! -e "$env/output_img" ]; then
    output_img=`cat ./env/output_img`
else
    echo "Please specify an output initrd path with file name in ./env/output_img"
    exit 1
fi

(cd "$bd" ; find . | cpio --quiet -H newc -o | gzip -9 -n > "$output_img")

echo Wrote to "$output_img"

#chown tftpboot.tftpboot "$output_img"


