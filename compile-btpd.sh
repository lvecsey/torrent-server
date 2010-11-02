#!/bin/sh

bd=`cat ./env/bd`

install_path=`pwd`/"$bd"/root/btpd-git

echo install path is "$install_path"

(cd "$bd"/btpd ; autoreconf ; mkdir decimate ; cd decimate ; ../configure --prefix="$install_path" ; make ; make install)
