#!/usr/bin/env bash

flower () {
    echo "Starting Airflow Celery Flower..."
    airflow celery flower \
        --port 5555 \
        --basic-auth ${USERNAME}:${PASSWORD} \
        --url-prefix /flower
}
