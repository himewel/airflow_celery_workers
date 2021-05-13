#!/usr/bin/env bash

worker () {
    echo "Removing older pid files..."
    rm ${AIRFLOW_HOME}/airflow-worker.pid

    echo "Starting Airflow Celery Worker..."
    airflow celery worker
}
