#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:
  download_data_script:
    type: File
    
outputs:
  output:
    type: File
    outputSource: download_data/download_file

steps:
  download_data:
    run: steps/download_data.cwl
    in:
      download_data_script_file: download_data_script
    out: download_file