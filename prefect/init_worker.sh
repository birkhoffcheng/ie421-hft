#!/bin/bash
sudo yum -y install git gcc pciutils epel-release python-devel python-pip
sudo pip install --upgrade pip
sudo pip install -U prefect
sudo prefect config set PREFECT_API_URL=http://192.168.50.101:4200/api
