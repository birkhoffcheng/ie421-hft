cwlVersion: v1.0
class: CommandLineTool

baseCommand: [sudo,sh]

requirements:
  ResourceRequirement:
    outdirMin: 5

inputs:
  parse_data_script_file:
    type: File
    inputBinding:
      position: 1

  download_zip:
    type: File
    inputBinding:
      position: 2

  parse_iex_pcap_script_file:
    type: File
    inputBinding:
      position: 3

outputs:
  book_snapshot1:
    type: File
    outputBinding:
      glob: '*_book_updates.csv.gz'

  book_snapshot2:
    type: File
    outputBinding:
      glob: '*_trades.csv.gz'
  
  text_tick_data:
    type: File
    outputBinding:
      glob: 'tick_*_*.txt.gz'

