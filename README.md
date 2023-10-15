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

Sama seperti sebelumnya, kita akan membuat subdomain rjp.baratayuda.abimanyu.d21.com yang sebelumnya sudah kita buat. Kita akan buat di node Werkudara, dengan IP yang mengarah ke Abimanyu.

### scriptWerkudara.sh
Berikut adalah scriptnya:
```
zone=$'zone "rjp.baratayuda.abimanyu.d21.com" {
        type master;
        file "/etc/bind/rjp/rjp.baratayuda.abimanyu.d21.com";
};'

pattern='zone \"rjp.baratayuda.abimanyu.d21.com\"'

if grep -q "^$pattern" "/etc/bind/named.conf.local"; then
 echo "Zone sudah ada di file konfigurasi"
else
 echo "$zone" >> /etc/bind/named.conf.local
 echo "File konfigurasi berhasil diupdate"
fi

mkdir /etc/bind/rjp
cp /etc/bind/db.local /etc/bind/rjp/rjp.baratayuda.abimanyu.d21.com

bindvar=$';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     rjp.baratayuda.abimanyu.d21.com. root.rjp.baratayuda.abimanyu.d21.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      rjp.baratayuda.abimanyu.d21.com.
@               IN      A       10.32.3.3
www             IN      CNAME   rjp.baratayuda.abimanyu.d21.com.
@               IN      AAAA    ::1
'

echo "$bindvar" > /etc/bind/rjp/rjp.baratayuda.abimanyu.d21.com
```

Testing dilakukan dengan cara melakukan ping ke rjp.baratayuda.abimanyu.d21.com
![Hasil 8](https://github.com/barpeot/Jarkom-Modul-2-D21-2023/assets/114351382/f5c862fa-c435-424e-81d6-65aa85e29550)


## Soal 9
Untuk nomor 9, yang perlu kita lakukan adalah menginstall Nginx dan PHP pada node Arjuna, Wisanggeni, Abimanyu, dan Prabukusuma menggunakan script di bawah ini:
```
apt-get update
apt-get install nginx wget unzip php php-fpm -y
```

Kemudian untuk node client Nakula dan Sadewa, kita juga install lynx untuk membuka webnya. Tidak lupa untuk mengembalikan nameserver menuju ke IP Yudhistira dan Werkudara
```
#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install lynx dnsutils -y


echo nameserver 10.32.2.2 > /etc/resolv.conf
echo nameserver 10.32.2.3 >>/etc/resolv.conf
```

## Soal 10
Pertama, kita harus memastikan bahwa pada Arjuna kita akan membagi load balancer menuju ke node worker dengan masing-masing port yang sudah ditentukan.
### scriptArjuna.sh
```
server=$' upstream myweb  {
        server 10.32.3.2:8003; #IP wisang
        server 10.32.3.3:8002; #IP abim
        server 10.32.3.4:8001; #IP prabuku
 }

 server {
     listen 80;
     server_name arjuna.d21.com;

     location / {
     proxy_pass http://myweb/;
     }
 }'
```
Kita simpan ke dalam file baru bernama lb-arjuna.d21.com pada folder Nginx. Selanjutnya kita hapus file default yang merupakan halaman default Nginx. Setelah itu kita restart Nginx nya.
```
echo "$server" > "/etc/nginx/sites-available/lb-arjuna.d21.com"

ln -s /etc/nginx/sites-available/lb-arjuna.d21.com /etc/nginx/sites-enabled

rm /etc/nginx/sites-enabled/default

service php7.0-fpm start

service nginx restart
```


Setelah Arjuna sudah kita setting, maka kita akan lakukan setting pada ketiga worker, misalnya kita akan melakukan setting pada worker Prabukusuma terlebih dahulu. 

Pertama, kita download requirement yang sudah disediakan linknya pada soal. Kita gunakan wget, kemudian kita unzip juga. Setelah itu, folder hasil unzip kita masukkan ke dalam direktori /var/www/arjuna.d21.com yang merupakan direktori tempat kita menyimpan front-end dari web kita.

```
wget "https://drive.google.com/u/0/uc?id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX&export=download" -O "arjuna.d21.com.zip"

unzip -o "arjuna.d21.com.zip"

rm -r "/var/www/arjuna.d21.com"

cp -r arjuna.yyy.com /var/www/arjuna.d21.com

rm -r "arjuna.yyy.com"

rm "arjuna.d21.com.zip"
```

Setelah itu, kita masukkan konfigurasi untuk membuat web server arjuna.d21.com, kita set juga sesuai dengan port pada soal. Kita juga harus menyamakan versi php-fpm dengan yang kita install agar tidak terjadi error. Kemudian kita lakukan symlink dan restart Nginx beserta start pada php-fpmnya

```
server=$'
server {

     listen 8001;

     root /var/www/arjuna.d21.com;

     index index.php index.html index.htm;
     server_name arjuna.d21.com;

     location / {
             try_files $uri $uri/ /index.php?$query_string;
     }

     # pass PHP scripts to FastCGI server
     location ~ .php$ {
     include snippets/fastcgi-php.conf;
     fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
     }

 location ~ /.ht {
             deny all;
     }

     error_log /var/log/nginx/arjuna.d21.com_error.log;
     access_log /var/log/nginx/arjuna.d21.com_access.log;
 }
'

echo "$server" > "/etc/nginx/sites-available/arjuna.d21.com"

ln -s /etc/nginx/sites-available/arjuna.d21.com /etc/nginx/sites-enabled

rm /etc/nginx/sites-enabled/default

service php7.0-fpm start

service nginx restart
```

Kita lakukan hal yang sama pada node Abimanyu dan node Wisanggeni dengan menyesuaikan portnya masing-masing.
Kita bisa testing dengan mencoba melakukan lynx berkali-kali ke arjuna.d21.com pada node client Nakula. Ketika berhasil, maka keterangan pada web akan berubah-ubah, tergantung pada web server mana kita sedang terhubung.

Contoh tersambung ke Wisanggeni
![10_Wisanggeni](https://github.com/barpeot/Jarkom-Modul-2-D21-2023/assets/114351382/2bd4686b-6f72-4393-b65e-d768c4b2abda)

Contoh tersambung ke Abimanyu
![10_Abimanyu](https://github.com/barpeot/Jarkom-Modul-2-D21-2023/assets/114351382/9fb37751-9d75-4e5a-9f51-6135cd0328ce)

Contoh tersambung ke Prabukusuma
![10_Prabukusuma](https://github.com/barpeot/Jarkom-Modul-2-D21-2023/assets/114351382/b85a68e0-bc29-4fea-9146-bd2c92e420a3)


## Soal 11

Kita install Apache dulu pada node Abimanyu, kemudian download requirement pada link di soal, unzip dan pindahkan ke /var/www/abimanyu.d21.com, kemudian kita melakukan konfigurasi pada web servernya dengan tambahkan
```
 ServerAlias www.abimanyu.d21.com
```

Jangan lupa kita enable servernya dengan
```
a2ensite abimanyu.d21.com
```
dan restart Apachenya juga

### scriptAbimanyu.sh

```
config=$"
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.d21
        ServerName abimanyu.d21.com
        ServerAlias www.abimanyu.d21.com

         Alias "/home" "/var/www/abimanyu.d21/index.php/home"

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"


rm -r "/var/www/abimanyu.d21"

echo "$config" > "/etc/apache2/sites-available/abimanyu.d21.com.conf"

wget "https://drive.google.com/u/0/uc?id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc&export=download" -O "abimanyu.d21.com.zip"

unzip -o "abimanyu.d21.com.zip"

mv -i "abimanyu.yyy.com" "/var/www/abimanyu.d21"

rm "abimanyu.d21.com.zip"

a2ensite abimanyu.d21.com

```

Testing dilakukan dengan melakukan lynx ke abimanyu.d21.com lewat Client

![11_Hasil](https://github.com/barpeot/Jarkom-Modul-2-D21-2023/assets/114351382/79bfad7f-7a75-4753-8f64-5e50f9ca33b0)


## Soal 12

## Soal 13

## Soal 14

## Soal 15

## Soal 16

## Soal 17

## Soal 18

## Soal 19

## Soal 20
