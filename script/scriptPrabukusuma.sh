#!/bin/bash

apt-get update
apt-get install nginx wget unzip php php-fpm -y

wget "https://drive.google.com/u/0/uc?id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX&export=download" -O "arjuna.d21.com.zip"

unzip -o "arjuna.d21.com.zip"

rm -r "/var/www/arjuna.d21.com"

cp -r arjuna.yyy.com /var/www/arjuna.d21.com

rm -r "arjuna.yyy.com"

rm "arjuna.d21.com.zip"

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