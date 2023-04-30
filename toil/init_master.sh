#!/bin/bash
sudo apt-get update
sudo apt -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
sudo curl -O https://www.python.org/ftp/python/3.9.15/Python-3.9.15.tar.xz
sudo tar -xf Python-3.9.15.tar.xz
cd Python-3.9.15/ 
sudo ./configure --enable-optimizations
sudo make altinstall
sudo apt-get -y install build-essential vim git python3-pip gcc
cd ..
sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3.9 get-pip.py
sudo rm /usr/bin/python
sudo ln -s /usr/local/bin/python3.9 /usr/bin/python
sudo pip install --upgrade pip
# sudo pip install virtualenv
# virtualenv ./venv
# source ./venv/bin/activate
# pip install toil[all]
