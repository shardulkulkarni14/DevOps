# main.py

import os

def process_input(input_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Filter out lines containing 'u'
    lines = [line for line in lines if 'u' not in line]

    # Sort lines by the number of words
    lines.sort(key=lambda x: len(x.split()))

    # Print the output
    for line in lines:
        # Split the line into columns
        columns = line.strip().split('\t')

        # Exclude column 7 (index 6)
        del columns[6]

        # Print [number of words]:[line without column 7]
        print("{}:\t{}".format(len(line.split()), '\t'.join(columns)))

if __name__ == "__main__":
    # Use an absolute path to the input file
    current_directory = os.path.dirname(os.path.abspath(__file__))
    input_file = os.path.join(current_directory, "input.txt")
    
    process_input(input_file)
