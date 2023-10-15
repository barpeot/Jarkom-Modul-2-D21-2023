#!/bin/bash

apt-get update
apt-get install bind9 -y

zone=$'
zone "arjuna.d21.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.d21.com";
};'

pattern='zone \"arjuna.d21.com\"'

if grep -q "^$pattern" "/etc/bind/named.conf.local"; then
 echo "Zone sudah ada di file konfigurasi"
else
 echo "$zone" >> /etc/bind/named.conf.local
 echo "File konfigurasi berhasil diupdate"
fi

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/arjuna.d21.com

bindvar=$';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.d21.com. root.arjuna.d21.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.d21.com.
@       IN      A       10.32.1.4
www     IN      CNAME   arjuna.d21.com.
@       IN      AAAA    ::1
'

echo "$bindvar" > /etc/bind/jarkom/arjuna.d21.com


zone=$'zone "abimanyu.d21.com" {
        type master;
        notify yes;
        also-notify { 10.32.2.3; }; #ip werkudara
        allow-transfer { 10.32.2.3; }; #ip werkudara
        file "/etc/bind/jarkom/abimanyu.d21.com";
};'

pattern='zone \"abimanyu.d21.com\"'

if grep -q "^$pattern" "/etc/bind/named.conf.local"; then
 echo "Zone sudah ada di file konfigurasi"
else
 echo "$zone" >> /etc/bind/named.conf.local
 echo "File konfigurasi berhasil diupdate"
fi

zone=$'
zone "3.32.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/3.32.10.in-addr.arpa";
};'

pattern='zone \"3.32.10.in-addr.arpa\"'

if grep -q "^$pattern" "/etc/bind/named.conf.local"; then
 echo "Zone sudah ada di file konfigurasi"
else
 echo "$zone" >> /etc/bind/named.conf.local
 echo "File konfigurasi berhasil diupdate"
fi

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.d21.com
cp /etc/bind/db.local /etc/bind/jarkom/3.32.10.in-addr.arpa

bindvar=$';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.d21.com. root.abimanyu.d21.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      abimanyu.d21.com.
@               IN      A       10.32.3.3
www             IN      CNAME   abimanyu.d21.com.
parikesit       IN      A       10.32.3.3
www.parikesit   IN      CNAME   parikesit
ns1             IN      A       10.32.2.3
baratayuda      IN      NS      ns1
@               IN      AAAA    ::1
'

echo "$bindvar" > /etc/bind/jarkom/abimanyu.d21.com

bindvar=$';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.d21.com. root.abimanyu.d21.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
3.32.10.in-addr.arpa.   IN      NS      abimanyu.d21.com.
3                       IN      PTR     abimanyu.d21.com.
'

echo "$bindvar" > /etc/bind/jarkom/3.32.10.in-addr.arpa

options=$'
options {
        directory "/var/cache/bind";

        // forwarders {
        //      0.0.0.0;
        // };

        //dnssec-validation auto;
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};'

echo "$options" > /etc/bind/named.conf.options

service bind9 restart

#lanjutkan dengan running script6werkudara.sh di werkudara