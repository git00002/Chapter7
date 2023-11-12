#!/usr/bin/env python3

import google.generativeai as palm
palm.configure(api_key='AIzaSyBE-J8MjZX3xckr8XUtySljZ51o80zFqeE')

#data = '{  \"prompt": 
#\
#'\'\'{
#}
#\'\'\'
#palm.configure(api_key=\"GOOGLE_API\")
#data = { ```bash function _data(){
#        "prompt": "context",
#        "messages": [
#            {
#                "role": "system",
#                "content": system_message
#            },
#            {
#                "role": "user",
#                "content": prompt_text
#            }
#        ]
#    }

defaults = {
  'model': 'models/text-bison-001',
  'temperature': 0.7,
  'candidate_count': 1,
  'top_k': 40,
  'top_p': 0.95,
  'max_output_tokens': 1024,
  'stop_sequences': [],
  'safety_settings': [{"category":"HARM_CATEGORY_DEROGATORY","threshold":0},{"category":"HARM_CATEGORY_TOXICITY","threshold":1},{"category":"HARM_CATEGORY_VIOLENCE","threshold":2},{"category":"HARM_CATEGORY_SEXUAL","threshold":2},{"category":"HARM_CATEGORY_MEDICAL","threshold":2},{"category":"HARM_CATEGORY_DANGEROUS","threshold":2}],
}
#prompt = f"""{data}
#"""


response = palm.generate_text(
  **defaults,
  prompt='\"prompt\": \"declare -A intents\nintents[\"greet\"]=\"Hello! How can I help you?\"\nintents[\"goodbye\"]=\"Goodbye Have a great day\"\nintents[\"help\"]=\"I can assist with basic tasks. Try asking a question.\"\nintents[\"unknown\"]=\"Im sorry, I dont understand that command.\"\n\nprocess_input() {\n    local input_text=\"$1\"\n    input_text=$(echo \"$input_text\" | tr [:upper:] [:lower:])  # Convert input to lowercase for case insensitivity\n\n    # Check for predefined intents and respond accordingly\n    case \"$input_text\" in\n        *hello*)\n            echo \"${intents[\"greet\"]}\"\n            ;;\n        *goodbye*)\n            echo \"${intents[\"goodbye\"]}\"\n            ;;\n        *help*)\n            echo \"${intents[\"help\"]}\"\n            ;;\n        *)\n            echo \"${intents[\"unknown\"]}\"\n            ;;\n    esac\n}\n\n# Main loop for user interaction\nwhile true; do\n    read -p \"You: \" user_input\n    if [ \"$user_input\" = \"exit\"'
)
print(response.result)

