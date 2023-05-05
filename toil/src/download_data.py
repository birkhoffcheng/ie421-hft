print('downloading data...............')

import os

parent_dir = os.path.dirname(os.getcwd())
# file_path = os.path.join(parent_dir, 'tmp.txt')

with open('tmp.txt', 'w') as f:
    f.write(parent_dir)