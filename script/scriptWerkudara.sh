#!/bin/bash

apt-get update
apt-get install bind9 -y

zone='
zone "abimanyu.d21.com" {
        type slave;
        masters { 10.32.2.2; }; #ip yudh
        file "/var/lib/bind/abimanyu.d21.com";
};'

echo "$zone" > /etc/bind/named.conf.local


zone='
zone "baratayuda.abimanyu.d21.com" {
        type master;
        file "/etc/bind/baratayuda/baratayuda.abimanyu.d21.com";
        allow-transfer { 10.32.2.2; };
};'

pattern='zone \"baratayuda.abimanyu.d21.com\"'

if grep -q "^$pattern" "/etc/bind/named.conf.local"; then
 echo "Zone sudah ada di file konfigurasi"
else
 echo "$zone" >> /etc/bind/named.conf.local
 echo "File konfigurasi berhasil diupdate"
fi

mkdir /etc/bind/baratayuda
cp /etc/bind/db.local /etc/bind/baratayuda/baratayuda.abimanyu.d21.com

bindvar=$';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.d21.com. root.baratayuda.abimanyu.d21.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.d21.com.
@       IN      A       10.32.3.3
www     IN      CNAME   baratayuda.abimanyu.d21.com.
ns1     IN      A       10.32.2.2
rjp     IN      NS      ns1
@       IN      AAAA    ::1
'

echo "$bindvar" > /etc/bind/baratayuda/baratayuda.abimanyu.d21.com

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