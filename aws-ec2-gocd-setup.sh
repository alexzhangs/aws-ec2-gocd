#!/bin/bash

# Exit on any error
set -o pipefail -e

# Debug
if [[ $DEBUG -gt 0 ]]; then
    set -x
else
    set +x
fi


build=${1:?}

# Server
server="https://download.go.cd/binaries/${build}/rpm/go-server-${build}.noarch.rpm"
wget "$server"
rpm -ivh "go-server-${build}.noarch.rpm"

# t2.micro run into out of memory issue without swap
aws-ec2-swap.sh 4096 # MB

service go-server restart

# Agent
agent="https://download.go.cd/binaries/${build}/rpm/go-agent-${build}.noarch.rpm"
wget "$agent"
rpm -ivh "go-agent-${build}.noarch.rpm"

service go-agent start

exit
