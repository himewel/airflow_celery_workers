#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

replace() {
    local server=$1
    sed -i "s/SERVER-NAME/${server}/g" /etc/nginx/sites-available/proxy
}

install_packages() {
    echo 'Update repository'
    apt-get update -qq
    echo 'Upgrade ...'
    apt-get upgrade -qqq
    echo 'Install curl'
    apt-get install curl -qqq
    echo 'Install docker'
    apt-get install docker -qqq
    echo 'Show docker version'
    docker -v
    echo 'Install docker-compose'
    apt-get install docker-compose -qqq
    echo 'Show docker-compose version'
    docker-compose --version
    echo 'Install nginx'
    apt-get install nginx-core -qqq
    echo 'Show nginx version'
    nginx -v
}

config_nginx() {
    echo 'Remove default nginx site'
    rm /etc/nginx/sites-enabled/default
    echo 'Create proxy site on nginx'
    mv proxy /etc/nginx/sites-available/

    external_ip=$(curl -s http://whatismyip.akamai.com/)
    replace $external_ip
    ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy
    nginx -t
    nginx -s reload
}

setup_services() {
    curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
    bash add-monitoring-agent-repo.sh
    apt-get-get update -qqq
    apt-get-get install stackdriver-agent -qqq
    rm -rf add-monitoring-agent-repo.sh

    service stackdriver-agent start
    systemctl enable stackdriver-agent
    systemctl restart nginx
    systemctl enable nginx
    systemctl enable docker
}

install_packages
config_nginx
setup_services
