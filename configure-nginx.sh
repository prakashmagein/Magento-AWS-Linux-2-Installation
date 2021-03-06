#!/bin/bash

#remove default
sed -i 's/80/8080/g'  /etc/nginx/nginx.conf
sed -i 's/80/8080/g'  /etc/nginx/conf.d/default.conf

# Run when magento files are in place 

cat > /etc/nginx/conf.d/magento.conf<<EOF
server {
  listen 80;
  server_name _;
  set \$MAGE_ROOT /var/www/html/magento;
  
  ##ADDITIONAL_CONFIG
  
  include /var/www/html/magento/nginx.conf.sample;
}

# PHP-FPM FastCGI server
# network or unix domain socket configuration

upstream fastcgi_backend {
        server unix:/run/php-fpm/www.sock;
}
EOF

# test Nginx config 

sudo nginx -t
