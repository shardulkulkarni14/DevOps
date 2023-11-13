def process_input(input_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Filter out lines containing 'u'
    lines = [line for line in lines if 'u' not in line]

    # Sort lines by the number of words
    # lines.sort(key=lambda x: len(x.split()))
    lines.sort()

    # Print the output to stdout and save it to output.txt
    with open("output.txt", 'w') as output_file:
        for line in lines:
            # Split the line into columns
            columns = line.strip().split('\t')

            # Exclude column 7 (index 6)
            del columns[6]

            # Print [number of words]:[line without column 7]
            output_line = "{count}:{content}".format(count=len(line.split()), content='\t'.join(columns))
            print(output_line)
            output_file.write(output_line + '\n')

if __name__ == "__main__":
    input_file = "input.txt"
    process_input(input_file)
