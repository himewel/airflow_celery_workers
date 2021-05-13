FROM apache/airflow:2.0.2

COPY ./tools ./tools

USER root

RUN chown -R airflow ${AIRFLOW_HOME} \
    && chmod +x ./tools/*.sh

USER airflow

ENTRYPOINT [ "bash", "./tools/start_services.sh" ]
