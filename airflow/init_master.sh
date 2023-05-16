#!/bin/bash

pacman -Syu --noconfirm python-pip python-tqdm python-requests python-amqp tmux rabbitmq postgresql

systemctl start rabbitmq.service
systemctl enable rabbitmq.service
su postgres -c 'cd && initdb -D /var/lib/postgres/data'
systemctl start postgresql.service
systemctl enable postgresql.service

su postgres << EOF
cd
psql
CREATE DATABASE airflow_db;
CREATE USER airflow_user WITH PASSWORD 'airflow_pass';
GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow_user;
\c airflow_db postgres
GRANT ALL ON SCHEMA public TO airflow_user;
COMMIT;
EOF

pip install apache-airflow[celery]

airflow version
cp /vagrant/airflow/master.cfg ~/airflow/airflow.cfg

airflow db init
airflow users create -u admin -p admin -f Airflow -l Administrator -r Admin -e airflow@example.com
tmux new-session -s airflow -d 'airflow webserver'
sleep 1
tmux new-window -t airflow 'airflow scheduler'
