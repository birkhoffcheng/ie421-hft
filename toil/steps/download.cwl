cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

requirements:
  ResourceRequirement:
    tmpdirMin: 5
    outdirMin: 5

inputs:
  download_data_script_file:
    type: File
    inputBinding:
      prefix: -u
      position: 1

  start_date:
    type: string
    inputBinding:
      prefix: --start-date
      position: 2

  end_date:
    type: string
    inputBinding:
      prefix: --end-date
      position: 3

  download_dir:
    type: string
    inputBinding:
      prefix: --download-dir
      position: 4

outputs:
  download_file:
    type: File
    outputBinding:
      glob: '*.gz'
