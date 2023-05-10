#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
      
inputs:
  download_data_script:
    type: File
  start_date:
    type: string
  end_date:
    type: string
  download_dir:
    type: string

steps:
  download:
    run: steps/download.cwl
    in:
      download_data_script_file: download_data_script
      start_date: start_date
      end_date: end_date
      download_dir: download_dir
    out: [download_file]

outputs: 
  download_file:
    type: File
    outputSource: download/download_file