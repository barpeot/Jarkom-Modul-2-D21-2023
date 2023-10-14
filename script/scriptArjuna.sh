#!/bin/bash

apt-get update
apt-get install nginx php php-fpm -y

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

echo "$server" > "/etc/nginx/sites-available/lb-arjuna.d21.com"

ln -s /etc/nginx/sites-available/lb-arjuna.d21.com /etc/nginx/sites-enabled

rm /etc/nginx/sites-enabled/default

service php7.0-fpm start

service nginx restart