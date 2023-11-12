import os
import openai
import json
import argparse
from pyttsx3 import speak as s
def get_user_message_from_file(file_path):
    with open(file_path, 'r') as file:
        return file.read().strip()

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Read user message from a file and call OpenAI API.")
parser.add_argument("file_path", help="Path to the file containing the user's initial message.")
args = parser.parse_args()
#with open('~/palm2.py','r') as file:
#    args.file_path = file.read() 
# Initialize OpenAI API key
openai.api_key = os.getenv("OPENAI_API_KEY")

# Initialize conversation messages
messages = [
    {
        "role": "system",
        "content": "You will be provided some python code snippet. Your task is to add a argument parser to the example provided. ."
    },
    {
        "role": "user",
#        "content": get_user_message_from_file(args.file_path)
        "content": get_user_message_from_file(args.file_path)
    }
]

while True:
    # Create the ChatCompletion request
    response = openai.ChatCompletion.create(
#        model="gpt-4",
        model="gpt-3.5-turbo",
        messages=messages,
        temperature=0.9,
        max_tokens=1806,
        top_p=0.01,
        frequency_penalty=0,
        presence_penalty=0
    )
    
    # Extract and print the assistant's message from the response JSON
    assistant_message = response['choices'][0]['message']['content']
    log("Assistant: ", assistant_message)
    s(assistant_message)
    
    # Add the assistant's message to the conversation history
    messages.append({
        "role": "assistant",
        "content": assistant_message
    })

    # Ask for a follow-up question
    follow_up = input("Do you have a follow-up question? (y/n): ")
    if follow_up.lower() == 'n':
        break

    # Get the follow-up question from the user
    follow_up_question = input("Please enter your follow-up question: ")

    # Add the user's follow-up question to the conversation history
    messages.append({
        "role": "user",
        "content": follow_up_question
    })
