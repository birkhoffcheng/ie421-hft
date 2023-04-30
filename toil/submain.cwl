cwlVersion: v1.0
class: Workflow

inputs:
  download_data_script_file: File
  parse_data_script_file: File
  start_file: File

outputs:
  download_data_output_file:
    type: File
    outputSource: download_data/download_data_output_file
  parse_data_output_file:
    type: File
    outputSource: parse_data/parse_data_output_file

steps:
  download_data:
    run: steps/download_data.cwl
    in:
      script_file: download_data_script_file
      input_file: start_file
    out:
      [download_data_output_file]

  parse_data:
    run: steps/parse_data.cwl
    in:
      script_file: parse_data_script_file
      input_file: download_data/download_data_output_file
    out:
      [parse_data_output_file]
