#!/bin/bash
sudo yum -y install git gcc pciutils epel-release python-devel python-pip
sudo pip install --upgrade pip
sudo pip install -U prefect
sudo prefect server start
sudo prefect work-pool create hft-pool