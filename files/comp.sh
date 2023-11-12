#!/bin/bash

# Read pipe input
while IFS= read -r line
do
  payload="$line"
done

# Call OpenAI API script with pipe input
openai api completions.create -e text-davinci-001 -p "$payload" -M 256
