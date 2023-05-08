#!/bin/bash

source ~/venv/bin/activate
toil-cwl-runner --defaultDisk 5G --workDir `pwd` workflow.cwl config.yml