# Jarkom-Modul-2-D21-2023

# Anggota Kelompok:
+ Akbar Putra Asenti Priyanto (5025211004)
+ Farrela Ranku Mahhissa (5025211129)

## Soal 1
Pada soal ini diminta untuk membuat topologi sesuai dengan pembagian yang telah diberikan. Berikut adalah topologi yang kami gunakan:
![Topologi_7](/assets/1_topologi.png)

## Soal 2
Pada soal ini diminta untuk melakukan setup website arjuna.d21.com. Setup ini dilakukan di node Yudhistira dan mengarah ke ip arjuna (10.32.1.4).

### scriptYudhistira.sh
Pada node Yudhistira dilakukan edit pada /etc/bind/named.conf.local dan /etc/bind/jarkom/arjuna.d21.com sebagai directory dari arjuna.d21.com.

Berikut konfigurasi arjuna.d21.com di /etc/bind/named.conf.local
```
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
```
Berikut adalah konfigurasi arjuna.d21.com di /etc/bind/jarkom/arajuna.d21.com.
```
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
```
Berikut adalah hasil ping dari website arjuna.d21.com
![Hasil_2](/assets/2_hasil.png)

## Soal 3
Pada soal ini diminta untuk melakukan setup website abimanyu.d21.com. Setup ini dilakukan di node Yudhistira dan mengarah ke ip abimanyu (10.32.3.3).

### scriptYudhistira.sh
Berikut konfigurasi abimanyu.d21.com di /etc/bind/named.conf.local
```
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
```
Berikut adalah konfigurasi abimanyu.d21.com di /etc/bind/jarkom/abimanyu.d21.com.
```
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
```
Berikut adalah hasil ping dari website abimanyu.d21.com
![Hasil_3](/assets/3_hasil.png)

## Soal 4
Pada solusi soal sebelumnya terdapat baris yang mengatur subdomain parikesit.abimanyu.d21.com

### scriptYudhistira.sh
```
parikesit       IN      A       10.32.3.3
www.parikesit   IN      CNAME   parikesit
```
Baris ini menambahkan subdomain parikesit.abimanyu.d21.com dan mengarahkannya ke ip abimanyu.

Berikut adalah hasil ping dari website parikesit.abimanyu.d21.com
![Hasil_4](/assets/4_hasil.png)

## Soal 5
Pada soal ini diminta untuk membuat reverse DNS untuk domain abimanyu.d21.com, maka perlu menambahkan halaman baru untuk reverse DNS di node Yudhistira.

### scriptYudhistira.sh
Berikut adalah setting reverse domain untuk website abimanyu.d21.com di /etc/bind/named.conf.local
```
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
```
Sedangkan berikut adalah setting reverse domain domain di root folder-nya /etc/bind/jarkom/3.32.10.in-addr.arpa. 
```
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
3.32.10.in-addr.arpa.   IN      NS      abimanyu.d21.com.
3                       IN      PTR     abimanyu.d21.com.
'

echo "$bindvar" > /etc/bind/jarkom/3.32.10.in-addr.arpa
```
Berikut adalah hasil reverse DNS dari ip abimanyu, ini dilakukan dengan bantuan ```dnsutils``` menggunakan command
```
host -t PTR "ip abimanyu"
```
![Hasil_5](/assets/5_hasil.png)

## Soal 6
Untuk menyelesaikan soal ini perlu mengubah node Werkudara sebagai DNS Slave dari node Yudhistira sehingga perlu dilakukan penambahan pada /etc/bind/named.conf.local node Yudhistira sebagai berikut:

### scriptYudhistira.sh
```    
also-notify { 10.32.2.3; }; #ip werkudara
allow-transfer { 10.32.2.3; }; #ip werkudara
file "/etc/bind/jarkom/abimanyu.d21.com";
```
Selain itu kita juga perlu melakukan perubahan pada node Werkudara sebagai berikut:

### scriptWerkudara.sh
```
zone='
zone "abimanyu.d21.com" {
        type slave;
        masters { 10.32.2.2; }; #ip yudh
        file "/var/lib/bind/abimanyu.d21.com";
};'

echo "$zone" > /etc/bind/named.conf.local
```
Untuk mengetesnya perlu dilakukan ```service bind stop``` pada node Yudhistira dan lakukan ```ping abimanyu.d21.com```
![Hasil_6](/assets/6_hasil.png)

## Soal 7
Untuk mendelegasikan subdomain dari Yudhistira ke Werkudara perlu ditambahkan baris di bawah ini di konfigurasi abimanyu Yudhistira di /etc/bind/named.conf.local kemudian baratayuda perlu diarahkan ke ip Werkudara.

### scriptYudhistira.sh
```
ns1             IN      A       10.32.2.3
baratayuda      IN      NS      ns1
```
Selanjutnya perlu dilakukan konfigurasi baratayuda.abimanyu.d21.com dengan mengarah ke ip abimanyu sebagai berikut:

### scriptWerkudara.sh
```
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
ns1     IN      A       10.32.2.3
rjp     IN      NS      ns1
@       IN      AAAA    ::1
'

echo "$bindvar" > /etc/bind/baratayuda/baratayuda.abimanyu.d21.com
```

Untuk kedua node perlu dilakukan perubahan pada /etc/bind/named.conf.options
```
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
```

Kemudian dilakukan ```ping baratayuda.abimanyu.d21.com``` untuk mengetes
![Hasil_7](/assets/7_hasil.png)

## Soal 8

## Soal 9

## Soal 10

## Soal 11

## Soal 12

## Soal 13

## Soal 14

## Soal 15

## Soal 16

## Soal 17

## Soal 18

## Soal 19

## Soal 20