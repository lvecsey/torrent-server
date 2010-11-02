#!/bin/bash

bd=`cat env/bd`

cp injections/init "$bd"/
chmod 755 "$bd"/init

