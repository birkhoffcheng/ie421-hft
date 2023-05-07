#!/bin/bash
vagrant ssh master -c "tmux new-session -s dask-scheduler -d 'sudo dask-scheduler --host 192.168.50.101'"
vagrant ssh worker1 -c "tmux new-session -s dask-worker -d 'sudo dask-worker tcp://192.168.50.101:8786'"
vagrant ssh worker2 -c "tmux new-session -s dask-worker -d 'sudo dask-worker tcp://192.168.50.101:8786'"
vagrant ssh worker1 -c "tmux new-session -s prefect-agent -d 'sudo prefect agent start -p hft-workpool'"
vagrant ssh worker2 -c "tmux new-session -s prefect-agent -d 'sudo prefect agent start -p hft-workpool'"
vagrant ssh master -c "tmux new-session -s prefect-master -d 'sudo prefect deploy ../../workflow/example.py:api_flow \
    -n my-first-deployment \
    -p hft-workpool'"