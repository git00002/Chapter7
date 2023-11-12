#!/bin/bash

# Define a dictionary of predefined intents and responses
declare -A intents
intents["greet"]="Hello! How can I help you?"
intents["goodbye"]="Goodbye! Have a great day!"
intents["help"]="I can assist with basic tasks. Try asking a question."
intents["unknown"]="I'm sorry, I don't understand that command."

# Function to process user input and return a response
process_input() {
local input_text="$1"
input_text=$(echo "$input_text" | tr [:upper:] [:lower:]) # Convert input to lowercase for case insensitivity

# Check for predefined intents and respond accordingly
case "$input_text" in
*hello*)
openai api chat_completions.create -m gpt-3.5-turbo -g user "${intents["help"]}" "${intents["greet"]}"
;;
*goodbye*)
echo "${intents["goodbye"]}"
;;
*help*)
openai api chat_completions.create -m gpt-4 -g user "${intents["help"]}"
;;
*create*)
# Extract the project argument from the command
project=$(echo "$input_text" | awk '{print $3}')
echo "Running custom command: openai api chat_completions.create -m gpt-3.5-turbo -g user "${intents["help"]}" "${intents["greet"]}"
#palmai api completions.create -e palm2-googlegenerativeai -p \"$project\""
# Call the actual command here
openai api chat_completions.create -m gpt-3.5-turbo -g user "${intents["help"]}" "${intents["greet"]}"
#palmai api completions.create -e palm2-googlegenerativeai -p "$project"
;;
**)
echo "${intents["unknown"]}"
;;
esac
}

# Main loop for user interaction
while true; do
read -p "You: " user_input
if [ "$user_input" = "exit" ]; then
echo "Chatbot: Goodbye!"
break
fi

response=$(process_input "$user_input")
echo "Chatbot: $response"
done

