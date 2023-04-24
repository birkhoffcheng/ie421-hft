cwlVersion: v1.0
class: CommandLineTool

baseCommand: sh

# There's absolutely no reason to pull this Docker image aside from
# testing that such a step works
hints:
  DockerRequirement:
    dockerPull: node:slim

inputs:
  script_file:
    type: File
    doc: Script to duplicate files
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
  input_file:
    type: File
    doc: Files to duplicate
    inputBinding:
      position: 4

outputs:
  duplicate_files:
    type: File[]
    outputBinding:
      glob: "*.txt"
