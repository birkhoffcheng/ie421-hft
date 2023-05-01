#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

baseCommand: [python3]

inputs: 
  download_data_script: 
    type: File
    inputBinding:
      prefix: -u

outputs:
  download_file:
    type: File
    outputBinding:
      glob: tmp.txt