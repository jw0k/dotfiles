#!/usr/bin/env bash

# shows a diff between a file that belongs to some package and the pristine version of that file

if [[ "$1" == "" ]];
then
    echo "Example usage: diff-pack-file /etc/pacman.conf"
elif [[ -f "$1" ]];
then
    info="$(pacman -Qo $1)"
    pkg="$(echo $info | awk 'NF{ printf $(NF-1) }')"
    ver="$(echo $info | awk 'NF{ printf $NF }')"

    # check if installed from AUR
    if pacman -Qm "$pkg" > /dev/null;
    then
        # package installed locally (most likely AUR)
        archive="/home/mainuser/.cache/yay/${pkg}/${pkg}-${ver}-"
    else
        # package installed from a repository
        archive="/var/cache/pacman/pkg/${pkg}-${ver}-"
    fi

    icdiff <(bsdtar -xOf "${archive}"* "${1/\//}") "$1"
    exit 0
else
    echo "The provided file \e[0;31m${1}\e[0m does not exist."
    exit 1
fi
