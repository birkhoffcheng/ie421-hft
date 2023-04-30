print('data downloaded')

with open('../data/startpipe.txt', 'r') as f:
    print(f.read())

with open('download_data_output_file.txt', 'w') as f:
    f.write('data downloaded')