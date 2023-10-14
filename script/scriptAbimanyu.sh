#!/bin/bash

apt-get update
apt-get install nginx wget unzip php php-fpm -y
apt-get install apache2 libapache2-mod-php7.0 -y

wget "https://drive.google.com/u/0/uc?id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX&export=download" -O "arjuna.d21.com.zip"

unzip -o "arjuna.d21.com.zip"

rm -r "/var/www/arjuna.d21.com"

cp -r arjuna.yyy.com /var/www/arjuna.d21.com

rm -r "arjuna.yyy.com"

rm "arjuna.d21.com.zip"


server=$'
server {

     listen 8002;

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
        DocumentRoot /var/www/parikesit.abimanyu.d21
        ServerName parikesit.abimanyu.d21.com
        ServerAlias www.parikesit.abimanyu.d21.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 403 /error/403.html

        <Directory /var/www/parikesit.abimanyu.d21/public>
                Options +Indexes
                AllowOverride All
        </Directory>

        <Directory /var/www/parikesit.abimanyu.d21>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>

        <Directory /var/www/parikesit.abimanyu.d21/secret>
                Options -Indexes
                AllowOverride All
        </Directory>

         Alias "/js" "/var/www/parikesit.abimanyu.d21/public/js"

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
        # after it has been globally disabled with a2disconf.
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"

rm -r "/var/www/parikesit.abimanyu.d21"

echo "$config" > "/etc/apache2/sites-available/parikesit.abimanyu.d21.com.conf"

wget "https://drive.google.com/u/0/uc?id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS&export=download" -O "parikesit.abimanyu.d21.com.zip"

unzip -o "parikesit.abimanyu.d21.com.zip"

mv -i "parikesit.abimanyu.yyy.com" "/var/www/parikesit.abimanyu.d21"

htaccess=$"
RewriteEngine On
RewriteCond http://parikesit.abimanyu.d21.com/public/images/%{REQUEST_URI} ^(.*)abimanyu(.*)(.jpg|.png|.jpeg)$
RewriteCond http://parikesit.abimanyu.d21.com/public/images/%{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule ^(.*)$ http://parikesit.abimanyu.d21.com/public/images/abimanyu.png [R=301,L]
"

echo "$htaccess" > "/var/www/parikesit.abimanyu.d21/.htaccess"

a2enmod rewrite

rm "parikesit.abimanyu.d21.com.zip"

html=$"
<!DOCTYPE html>
<html>
<head>
    <title>Hiding Spot</title>
</head>
<body>
    <h1>Halo kamu berhasil menemukan aku</h1>
</body>
</html>
"

mkdir "/var/www/parikesit.abimanyu.d21/secret"
mkdir "/var/www/parikesit.abimanyu.d21/secret/html"

echo "$html" > "/var/www/parikesit.abimanyu.d21/secret/html/index.html"

a2ensite parikesit.abimanyu.d21.com

a2enmod auth_basic

htpasswd -bc /etc/apache2/.htpasswd Wayang baratayudad21

config1=$"
<VirtualHost *:14000>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.d21
        ServerName rjp.baratayuda.abimanyu.d21.com
        ServerAlias www.rjp.baratayuda.abimanyu.d21.com

        <Directory /var/www/rjp.baratayuda.abimanyu.d21>
                AuthType Basic
                AuthName \"Insert Credentials\"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particu/lar virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"

echo "$config1" > "/etc/apache2/sites-available/rjp.baratayuda.abimanyu.d21.com-14000.conf"

config2=$"
<VirtualHost *:14400>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.d21
        ServerName rjp.baratayuda.abimanyu.d21.com
        ServerAlias www.rjp.baratayuda.abimanyu.d21.com

        <Directory /var/www/rjp.baratayuda.abimanyu.d21>
                AuthType Basic
                AuthName \"Insert Credentials\"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particu/lar virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"

echo "$config2" > "/etc/apache2/sites-available/rjp.baratayuda.abimanyu.d21.com-14400.conf"

wget "https://drive.google.com/u/0/uc?id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6&export=download" -O "rjp.baratayuda.abimanyu.d21.com.zip"

rm -r "/var/www/rjp.baratayuda.abimanyu.d21"

unzip -o "rjp.baratayuda.abimanyu.d21.com.zip"

rm "rjp.baratayuda.abimanyu.d21.com.zip"

mv -i "rjp.baratayuda.abimanyu.yyy.com" "/var/www/rjp.baratayuda.abimanyu.d21"

ports=$"
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
"

echo "$ports" > "/etc/apache2/ports.conf"

a2ensite rjp.baratayuda.abimanyu.d21.com-14000

a2ensite rjp.baratayuda.abimanyu.d21.com-14400

a2dissite 000-default

service apache2 restart