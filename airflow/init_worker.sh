#!/bin/bash

pacman -Syu --noconfirm python-pip python-tqdm python-requests python-amqp python-psycopg2 tmux tcpdump

pip install apache-airflow[celery]

cp /vagrant/worker.cfg ~/airflow/airflow.cfg

tmux new-session -s airflow -d 'airflow celery worker'
