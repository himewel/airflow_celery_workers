#!/usr/bin/env bash

scheduler () {
    echo "Migrating Apache Airflow metadata..."
    airflow db upgrade

    echo "Starting Airflow Scheduler..."
    airflow scheduler
}
