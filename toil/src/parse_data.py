print('data parsed')


with open('download_data_output_file.txt', 'r') as f:
    print(f.read())
    
with open('parse_data_output_file.txt', 'w') as f:
    f.write('data parsed')