cwlVersion: v1.0
class: CommandLineTool

baseCommand: [python3, src/download_data.py]

inputs:
  input_file:
    type: File
    doc: The input text file

outputs:
  output_file:
    type: File
    outputBinding:
      glob: ../data/output.txt

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  stdin: true
  stdout: true
