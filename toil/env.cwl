#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: env
requirements:
  EnvVarRequirement:
    envDef:
      VM_HOST: "192.168.50.101"
inputs: []
outputs:
  example_out:
    type: stdout
stdout: tmp.txt