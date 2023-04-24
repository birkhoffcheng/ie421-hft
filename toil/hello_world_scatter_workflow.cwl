#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  hello_world_script: File
  duplicator_script: File
  make_caps_script: File
  names: string[]
  numbers: int[]

outputs:
  hello_world_outputs:
    type: File[]
    outputSource: scatter_hello_world/final_outputs_tar

steps:
  scatter_hello_world:
    run: hello_world_subworkflow.cwl
    in:
      hello_world_script_file: hello_world_script
      duplicator_script_file: duplicator_script
      make_caps_script_file: make_caps_script
      name: names
      number: numbers
    out:
      [hello_world_output_file, duplicate_files, final_outputs_tar]
    scatter: [name, number]
    scatterMethod: flat_crossproduct
