#!/bin/bash

virtualenv ~/venv
. ~/venv/bin/activate
# toil-cwl-runner --defaultDisk 5G --workDir `pwd` workflow.cwl config.yml


today=$(date -d "yesterday" +%Y-%m-%d)
sed -i "s/start_date: .*/start_date: $today/" config.yml
sed -i "s/end_date: .*/end_date: $today/" config.yml

toil-cwl-runner --workDir `pwd` downloadworkflow.cwl config.yml