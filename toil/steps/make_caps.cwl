cwlVersion: v1.0
class: CommandLineTool

baseCommand: sh

inputs:
  script_file:
    type: File
    doc: Script to change a file's alphabet characters to all caps
    inputBinding:
      position: 1
  name:
    type: string
    doc: Name to be part of a unique directory identifier
    inputBinding:
      position: 2
  number:
    type: int
    doc: Number to be part of a unique directory identifier
    inputBinding:
      position: 3
  input_files:
    type: File[]
    doc: Files to read in
    inputBinding:
      position: 4

outputs:
  final_outputs_tar:
    type: File
    outputBinding:
      glob: "shout*tar.gz"
