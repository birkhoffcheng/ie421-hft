#!/bin/bash

pacman -Syu --noconfirm python-pip python-tqdm python-requests python-amqp tmux tcpdump

pip install apache-airflow[celery]

airflow version
cp /vagrant/worker.cfg ~/airflow/airflow.cfg

tmux new-session -s airflow -d 'airflow celery worker'
