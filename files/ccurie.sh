#!/bin/bash
my_function() {
  for i in "$@"; do
    echo "Running command with argument: $i"
    openai api completions.create -M 256 -e curie:ft-christopher-bruns-2023-08-11-07-22-31 -p "$i" 
  done
}
my_function
