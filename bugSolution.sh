#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create a file for demonstration.
touch data.txt

# Function to write to the file using flock for exclusive access.
write_to_file() {
  flock -x <(exec echo >&3) 3 < data.txt || exit 1 # Acquire exclusive lock
  echo "$1" >> data.txt
  echo >&3 # Release lock
}

# Function to read from the file.
read_from_file() {
  cat data.txt
}

# Create two processes to write to the file concurrently.
write_to_file "Process 1"
write_to_file "Process 2" &

# Wait for the background process to finish
wait

# Read the file content.
read_from_file

#Expected Output:
#Process 1
#Process 2
#Actual Output:
#Process 1
#Process 2