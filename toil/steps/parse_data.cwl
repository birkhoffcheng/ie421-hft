cwlVersion: v1.0
class: CommandLineTool

baseCommand: [python3, src/parse_data.py]

inputs:
  download_data_output_file:
    type: File
    doc: The input text file

outputs:
  parse_data_output_file:
    type: File
    outputBinding:
      glob: 'parse_data/parse_data_output_file.txt'
