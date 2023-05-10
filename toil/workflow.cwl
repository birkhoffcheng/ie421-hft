#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
      
inputs:
  download_data_script:
    type: File
  parse_data_script:
    type: File
  start_date:
    type: string
  end_date:
    type: string
  download_dir:
    type: string
  parse_iex_pcap_script:
    type: File

steps:
  download:
    run: steps/download.cwl
    in:
      download_data_script_file: download_data_script
      start_date: start_date
      end_date: end_date
      download_dir: download_dir
    out: [download_file]
  
  parse:
    run: steps/parse.cwl
    in: 
      parse_data_script_file: parse_data_script
      download_zip: download_file
      parse_iex_pcap_script_file: parse_iex_pcap_script
    out: [book_snapshot1,book_snapshot2,text_tick_data]

outputs: 
  download_file:
    type: File
    outputSource: download/download_file
  book_snapshot1:
    type: File
    outputSource: parse/book_snapshot1
  book_snapshot2:
    type: File
    outputSource: parse/book_snapshot2
  text_tick_data:
    type: File
    outputSource: parse/text_tick_data