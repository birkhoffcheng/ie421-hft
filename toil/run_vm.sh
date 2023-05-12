#!/bin/bash

vagrant up 
vagrant ssh -c 'cd /workflow ; sh ./run_workflow.sh'