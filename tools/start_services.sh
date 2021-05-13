#!/usr/bin/env bash

SERVICE=$1
echo "SERVICE ${SERVICE}..."

source ./tools/flower.sh
source ./tools/scheduler.sh
source ./tools/webserver.sh
source ./tools/worker.sh

case $SERVICE in
    flower)
        flower
        ;;
    scheduler)
        scheduler
        ;;
    webserver)
        webserver
        ;;
    worker)
        worker
        ;;
    *)
        echo "ERROR: service name not recognized, try: scheduler, webserver, flower or worker"
        exit 1
        ;;
esac
