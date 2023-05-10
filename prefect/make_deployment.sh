#!/bin/bash 
mkdir data
mkdir data/DEEP
mkdir data/book_snapshots
mkdir data/text_tick_data
vagrant ssh master -c "tmux new-session -s prefect-sever -d 'sudo prefect server start --host 192.168.50.101'"
vagrant ssh master -c "sudo prefect work-pool create --type process hft-workpool"
vagrant ssh master -c "tmux new-session -s dask-scheduler -d 'sudo dask-scheduler --host 192.168.50.101'"
vagrant ssh worker1 -c "tmux new-session -s dask-worker -d 'sudo dask-worker tcp://192.168.50.101:8786'"
vagrant ssh worker2 -c "tmux new-session -s dask-worker -d 'sudo dask-worker tcp://192.168.50.101:8786'"
vagrant ssh worker1 -c "tmux new-session -s prefect-agent -d 'sudo prefect agent start -p hft-workpool'"
vagrant ssh worker2 -c "tmux new-session -s prefect-agent -d 'sudo prefect agent start -p hft-workpool'"
vagrant ssh master -c "tmux new-session -s prefect-master -d ' sudo prefect deploy /home/vagrant/workflow/hft.py:hft_flow -n my-first-deployment-1 -p hft-workpool'"
