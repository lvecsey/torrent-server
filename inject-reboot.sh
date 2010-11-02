#!/bin/bash

bd=`cat env/bd`

cp injections/reboot-if.sh "$bd"/
chmod 755 "$bd"/reboot-if.sh


