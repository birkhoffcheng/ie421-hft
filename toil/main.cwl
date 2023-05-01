#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  download_data_script:
    type: File

outputs:
  output:
    type: File
    outputSource: sub_download_data/download_file

steps:
  sub_download_data:
    run: submain.cwl
    in:
      download_data_script_file: download_data_script
    out: download_file