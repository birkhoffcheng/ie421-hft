#!/bin/bash
vagrant ssh worker1 -c "sudo prefect agent start -p hft-workpool &"
vagrant ssh worker2 -c "sudo prefect agent start -p hft-workpool &"
vagrant ssh master -c "sudo prefect deploy ../../workflow/example.py:api_flow \
    -n my-first-deployment \
    -p hft-workpool"