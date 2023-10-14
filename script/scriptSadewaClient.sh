#!/bin/bash
echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install lynx dnsutils -y

echo nameserver 10.32.2.2 > /etc/resolv.conf
echo nameserver 10.32.2.3 >> /etc/resolv.conf