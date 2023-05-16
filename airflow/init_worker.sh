#!/bin/bash

pacman -Syu --noconfirm python-pip python-tqdm python-requests python-amqp tmux tcpdump

pip install apache-airflow[celery]

mkdir -p ~/airflow
cp /vagrant/airflow/worker.cfg ~/airflow/airflow.cfg

tmux new-session -s airflow -d 'airflow celery worker'
