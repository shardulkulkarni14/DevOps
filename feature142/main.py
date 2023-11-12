
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
    word_count = sum(len(col.split()) for col in columns)
    print("{count}:\t{content}".format(count=word_count, content='\t'.join(columns)))
