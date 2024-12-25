#!/bin/bash

# This script demonstrates a race condition bug.

# Create a file for demonstration.
touch data.txt

# Function to write to the file.
write_to_file() {
  echo "$1" >> data.txt
}

# Function to read from the file.
read_from_file() {
  cat data.txt
}

# Create two processes to write to the file concurrently.
write_to_file "Process 1"
write_to_file "Process 2" & # Background process

# Wait for the background process to finish
wait

# Read the file content.
read_from_file

#Expected Output:
#Process 1
#Process 2
#Actual Output (May Vary):
#Process 1Process 2
#Process 2Process 1
#Process 1
#Process 2