#!/bin/sh
awk 'NR>=172 && NR<=362 {sum+=$7} END{print sum}' input.txt > output.txt
