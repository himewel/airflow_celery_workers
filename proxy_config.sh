#!/bin/sh

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

if [ "$1" == "" ]; then
  echo "Please give a server name"
  exit
fi

if [ "$2" == "" ]; then
  echo "Please give a proxy template file path"
  exit
fi

server_name=$1
template=$2

echo "Remove default nginx site"
rm /etc/nginx/sites-enabled/default

echo "Create proxy site on nginx"
/bin/cp -rf $template /etc/nginx/sites-available/proxy
sed -i "s/SERVER-NAME/${server_name}/g" /etc/nginx/sites-available/proxy
ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy

echo "Reloading nginx"
nginx -t
nginx -s reload
