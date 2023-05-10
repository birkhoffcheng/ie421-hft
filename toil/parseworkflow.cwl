#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
      
inputs:
  parse_data_script:
    type: File

  download_file:
    type: File

  parse_iex_pcap_script:
    type: File

steps:
  parse:
    run: steps/parse.cwl
    in: 
      parse_data_script_file: parse_data_script
      download_zip: download_file
      parse_iex_pcap_script_file: parse_iex_pcap_script
    out: [book_snapshot1,book_snapshot2,text_tick_data]

outputs: 
  book_snapshot1:
    type: File
    outputSource: parse/book_snapshot1
  book_snapshot2:
    type: File
    outputSource: parse/book_snapshot2
  text_tick_data:
    type: File
    outputSource: parse/text_tick_data