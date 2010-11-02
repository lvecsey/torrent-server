#!/bin/bash

bd=`cat ./env/bd`

(cd "$bd" ; git clone http://github.com/btpd/btpd.git ; cd btpd)
