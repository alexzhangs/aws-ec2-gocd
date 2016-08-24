#!/bin/bash

# Exit on any error
set -o pipefail -e

# Debug
if [[ $DEBUG -gt 0 ]]; then
    set -x
else
    set +x
fi


size=${1:?} # MB

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=$size
chmod 600 /var/swap.1
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

exit
