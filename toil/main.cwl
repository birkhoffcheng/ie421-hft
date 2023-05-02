#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  download_data_script:
    type: File

steps:
  download:
    run: steps/download_data.cwl
    in:
      download_data_script_file: download_data_script
    out: [download_file]

outputs: 
  download_file:
    type: File
    outputSource: download/download_file