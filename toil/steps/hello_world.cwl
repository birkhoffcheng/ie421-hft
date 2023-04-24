cwlVersion: v1.0
class: CommandLineTool

baseCommand: sh

inputs:
  script_file:
    type: File
    doc: Script to generate hello world text files
    inputBinding:
      position: 1
  name:
    type: string
    doc: Name of the person to greet
    inputBinding:
      position: 2
  number:
    type: int
    doc: ID number of the person to greet
    inputBinding:
      position: 3

outputs:
  hello_world_output_file:
    type: File
    outputBinding:
      glob: helloworld*.txt
