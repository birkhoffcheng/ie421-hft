#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  start_file: File

outputs:
  parse_data_output:
    type: File
    outputSource: datapipe/parse_data/parse_data_output_file

steps:
  datapipe:
    run: submain.cwl
    in:
      download_data_script_file: File
      parse_data_script_file: File
      start_file: start_file
    out:
      [download_data_output_file, parse_data_output_file]
