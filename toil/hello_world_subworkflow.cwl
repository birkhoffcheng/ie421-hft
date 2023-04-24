cwlVersion: v1.0
class: Workflow

inputs:
  hello_world_script_file: File
  duplicator_script_file: File
  make_caps_script_file: File
  name: string
  number: int

outputs:
  hello_world_output_file:
    type: File
    outputSource: hello_world/hello_world_output_file
  duplicate_files:
    type: File[]
    outputSource: duplicate_file/duplicate_files
  final_outputs_tar:
    type: File
    outputSource: make_caps/final_outputs_tar

steps:
  hello_world:
    run: steps/hello_world.cwl
    in:
      script_file: hello_world_script_file
      name: name
      number: number
    out:
      [hello_world_output_file]

  duplicate_file:
    run: steps/duplicate_file.cwl
    in:
      script_file: duplicator_script_file
      name: name
      number: number
      input_file: hello_world/hello_world_output_file
    out:
      [duplicate_files]

  make_caps:
    run: steps/make_caps.cwl
    in:
      script_file: make_caps_script_file
      input_files: duplicate_file/duplicate_files
      name: name
      number: number
    out:
      [final_outputs_tar]
