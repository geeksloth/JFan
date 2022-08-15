#!/bin/bash

#Require sudo
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

echo "settling to /usr/local/bin/jfan/..."
rm -r /usr/bin/jfan/ 2>/dev/null
mkdir -p /usr/local/bin/jfan
cp jfan.py /usr/local/bin/jfan/
echo "done"

echo "adding service to /lib/systemd/system/..."
cp jfan.service /lib/systemd/system/
chmod 644 /lib/systemd/system/jfan.service
echo "done"

echo "creating config at /etc/jfan/"
mkdir /etc/jfan/
cp config.json /etc/jfan/
chmod 664 /etc/jfan/config.json
echo "done"

echo "starting and enabling service..."
systemctl daemon-reload
systemctl start jfan
systemctl enable jfan
echo "done"

echo "jfan installed sucessfully!"
echo ""
echo "To configure, edit /etc/jfan/config.json (needs sudo)"
