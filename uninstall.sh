#!/bin/bash

#Require sudo
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

echo "removing service..."
systemctl stop jfan
systemctl disable jfan
echo "done"


echo "removing /usr/local/bin/jfan/..."
rm -r /usr/local/bin/jfan
rm -r /usr/bin/jfan 2>/dev/null
echo "done"

echo "removing service from /lib/systemd/system/..."
rm /lib/systemd/system/jfan.service
echo "done"

echo "removing config at /etc/jfan/"
rm -r /etc/jfan/
echo "done"

echo "reloading services"
systemctl daemon-reload
echo "done"

echo "jfan uninstalled sucessfully!"
echo ""
echo "If you are dissatisfied,"
echo "please create an issue at the repo."
