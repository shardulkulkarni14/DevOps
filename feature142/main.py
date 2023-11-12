
with open('input.txt', 'r') as file:
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
    print("{count}:\t{content}".format(count=len(line.split()), content='\t'.join(columns)))
