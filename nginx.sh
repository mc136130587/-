#!/bin/bash
useradd -s /sbin/nologin nginx
yum -y install gcc openssl-devel pcre-devel
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
make
make install
yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-mysql
yum -y install php-fpm
sed -i '65,71s/#//' /usr/local/nginx/conf/nginx.conf
sed -i '/SCRIPT_FILENAME/d' /usr/local/nginx/conf/nginx.conf
sed -i 's/fastcgi_params/fastcgi.conf/' /usr/local/nginx/conf/nginx.conf
/usr/local/nginx/sbin/nginx
systemctl start mariadb
systemctl start php-fpm
