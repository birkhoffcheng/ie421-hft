#!/bin/bash
vagrant ssh worker1 -c "tmux new-session -s prefect-agent -d 'sudo prefect agent start -p hft-workpool'"
vagrant ssh worker1 -c "tmux new-session -s prefect-agent -d 'sudo prefect agent start -p hft-workpool'"
vagrant ssh master -c "tmux new-session -s prefect-master -d 'sudo prefect deploy ../../workflow/example.py:api_flow \
    -n my-first-deployment \
    -p hft-workpool'"