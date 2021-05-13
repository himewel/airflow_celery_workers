#!/usr/bin/env bash

webserver () {
    echo "Removing older pid files..."
    rm ${AIRFLOW_HOME}/airflow-webserver.pid

    echo "Creating default user in UI..."
    airflow users create \
        --role ${ROLE} \
        --username ${USERNAME} \
        --password ${PASSWORD} \
        --firstname ${FIRSTNAME} \
        --lastname ${LASTNAME} \
        --email ${EMAIL}

    echo "Starting Airflow Webserver..."
    airflow webserver \
        --port 8080
}
