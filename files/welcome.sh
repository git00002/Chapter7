ffmpeg -i welcome_message.mp3 -f wav - | aplay#!/bin/bash

# Get the terminal's width
width=$(tput cols)

# Center the text in the middle of the screen
center() {
    printf "%*s\n" $(( (${#1} + width) / 2)) "$1"
}

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

# Display the message
center "${RED}Welcome back, Daddy!"
center "${GREEN}It's always a pleasure to serve you."
center "${BLUE}Here's a glimpse of your current folder:"
center "$(ls ./.)"
center "${CYAN}Enjoy your time in the Linux container!"
center "${WHITE}Your humble terminal."



# Save message to text
echo "Welcome back, Daddy! It's always a pleasure to serve you. Here's a glimpse of the device folder: $(ls ./.). Enjoy your time in the Linux container! Your humble terminal." > welcome_message.txt

# Convert text to audio
gtts-cli -f welcome_message.txt -l 'en' -o welcome_message.mp3

# Play the audio (using ffmpeg)
ffmpeg -i welcome_message.mp3 -f wav - | aplay
