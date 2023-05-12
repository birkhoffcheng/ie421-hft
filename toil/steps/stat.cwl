cwlVersion: v1.0
class: CommandLineTool

baseCommand: [sudo,sh]

inputs:
  stat_data_script_file:
    type: File
    inputBinding:
      position: 1

  candle_chart_script_file:
    type: File
    inputBinding:
      position: 2

  book_snapshot2_file:
    type: File
    inputBinding:
      position: 3

outputs:
  csv_file:
    type: File
    outputBinding:
      glob: '*.csv'