#!/bin/bash

bd=`cat env/bd`

mkdir -p "$bd"/etc/nut
cp injections/upsmon.conf "$bd"/etc/nut
chmod 644 "$bd"/etc/nut/upsmon.conf

mkdir -p "$bd"/root/bin
cp injections/nut-shutdown.sh "$bd"/root/bin
chmod 755 "$bd"/root/bin/nut-shutdown.sh
