#!/bin/bash

pacman -Syu --noconfirm python-pip tmux

AIRFLOW_VERSION=2.6.0
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
pip install tqdm pytz requests

airflow db init
airflow users create -u admin -p admin -f Airflow -l Administrator -r Admin -e airflow@example.com
tmux new-session -s airflow -d 'airflow webserver'
tmux new-window -t airflow 'airflow scheduler'
