#!/bin/bash

sudo apt-get install nginx
sudo apt-get install apache2-utils

sudo htpasswd -c /etc/nginx/htpasswd.users kibanauser

cat <<END >/etc/nginx/conf.d/kibana.conf
worker_processes  1;
events {
  worker_connections 1024;
}

http {

  upstream kibana {
    server 127.0.0.1:5601;
    keepalive 15;
  }


  server {
    listen 8882;

    location / {
      auth_basic "Restricted Access";
      auth_basic_user_file /etc/nginx/htpasswd.users;

      proxy_pass http://kibana;
      proxy_redirect off;
      proxy_buffering off;

      proxy_http_version 1.1;
      proxy_set_header Connection "Keep-Alive";
      proxy_set_header Proxy-Connection "Keep-Alive";
    }
  }
}

END

sudo service nginx restart
sudo service kibana restart