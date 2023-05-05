#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: SubworkflowFeatureRequirement
  EnvVarRequirement:
    envDef:
      VM_HOST: "192.168.50.101"

inputs:
  download_data_script:
    type: File

outputs:
  output:
    type: stdout
    outputSource: sub_download_data/download_file

steps:
  sub_download_data:
    run: submain.cwl
    in:
      download_data_script_file: download_data_script
    out: download_file