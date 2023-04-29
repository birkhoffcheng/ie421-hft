#!/bin/bash
Vagrant ssh worker1 -c "sudo prefect agent start -p hft-pool"
Vagrant ssh master -c "sudo prefect deploy /workflow/example.py:api_flow \
    -n my-first-deployment \
    -p hft-pool"