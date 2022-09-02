#!/usr/bin/env bash

if [[ ! -f /home/sandstorm/ssaw/linux_start.sh ]]
then
    mv /home/sandstorm/sandstorm-admin-wrapper/* /home/sandstorm/ssaw/
fi

# Start normally
exec ./linux_start.sh