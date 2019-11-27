#!/bin/bash

RHEL=$(xe template-list name-label=Red\ Hat\ Enterprise\ Linux\ 5.3\ \(32-bit\) --minimal)

distro="Red Hat Enterprise Linux 5.5"
arches=("32-bit" "64-bit")


for arch in ${arches[@]} ; do
    echo "Attempting $distro ($arch)"
    if [[ -n $(xe template-list name-label="$distro ($arch)" params=uuid --minimal) ]] ; then
        echo "$distro ($arch)" already exists, Skipping
    else

        NEWUUID=$(xe vm-clone uuid=$RHEL new-name-label="$distro ($arch)")
        xe template-param-set uuid=$NEWUUID other-config:install-methods=http,ftp,nfs \
         other-config:default_template=true 
	echo "Success"
    fi
done
echo "Done"
    

