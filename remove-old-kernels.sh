#! /bin/bash
#====================================================================
# remove-old-kernels.sh
#
# Copyright 2014 Fwolf <fwolf.aide+bin.public@gmail.com>
# All rights reserved.
#
# Distributed under the MIT License.
# http://opensource.org/licenses/mit-license
#
# Delete old linux kernels and images, will keep most recent previous version.
#
# @version  v1.0
# @link https://help.ubuntu.com/community/Lubuntu/Documentation/RemoveOldKernels
#====================================================================


PREVIOUS_VERSION=`dpkg -l 'linux-image-*' \
    | grep ^i | grep -v linux-image-generic \
    | tail -n 2 | head -n 1 \
    | awk '{print $3}' \
    | sed 's/linux-image-//' \
    | sed 's/\([\.0-9]\+\-[0-9]\+\).*/\1/' \
    `

CURRENT_VERSION=`uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/"`

REMOVE_VERSIONS=`dpkg -l 'linux-*' \
    | grep ^ii \
    | awk '{print $2}' \
    | grep -v linux-image-generic \
    | grep -v linux-headers-generic \
    | grep -v $PREVIOUS_VERSION \
    | grep -v $CURRENT_VERSION \
    | grep -E '(linux-image|linux-headers)' \
    `
sudo aptitude purge $REMOVE_VERSIONS
