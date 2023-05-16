#!/bin/bash

pacman -Syu --noconfirm python-pip python-amqp tmux rabbitmq postgresql

systemctl start rabbitmq
systemctl enable rabbitmq
su postgres -c 'initdb -D /var/lib/postgres/data'
systemctl start postgresql
systemctl enable postgresql

su postgres << EOF
psql
CREATE DATABASE airflow_db;
CREATE USER airflow_user WITH PASSWORD 'airflow_pass';
GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow_user;
\c airflow_db postgres
GRANT ALL ON SCHEMA public TO airflow_user;
COMMIT;
EOF

pip install apache-airflow[celery]

mkdir -p ~/airflow
cp /vagrant/airflow/master.cfg ~/airflow/airflow.cfg

airflow db init
airflow users create -u admin -p admin -f Airflow -l Administrator -r Admin -e airflow@example.com
tmux new-session -s airflow -d 'airflow webserver'
tmux new-window -t airflow 'airflow scheduler'
