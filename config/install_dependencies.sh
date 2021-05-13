#!/bin/sh

echo "Install stackdriver dependencies..."
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
bash add-monitoring-agent-repo.sh
rm add-monitoring-agent-repo.sh

echo "Update..."
apt-get update -qqq
echo "Upgrade..."
apt-get upgrade -qqq

echo "Install curl..."
apt-get install curl -qqq

echo "Install docker-compose"
apt-get install docker-compose -qqq
echo "Show docker version"
docker --version
echo "Show docker-compose version"
docker-compose --version

echo "Install nginx..."
apt-get install nginx-core -qqq
echo "Show nginx version"
nginx -v

echo "Install stackdriver agent..."
apt-get install stackdriver-agent -qqq

echo "Setup services...."
service stackdriver-agent start
systemctl restart nginx
systemctl enable stackdriver-agent
systemctl enable nginx
systemctl enable docker
