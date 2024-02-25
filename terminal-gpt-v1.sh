#!/bin/bash

# Generate an API Key from OpenAI and enter below
API_KEY="Enter your API KEY here"

# Prompt for user input
echo "Enter your message:"
read user_input

# Make request to OpenAI API and handle errors
response=$(curl -s -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    --data '{"model": "gpt-3.5-turbo", "messages": [{"role": "user", "content": "'"$user_input"'"}]}' \
    https://api.openai.com/v1/chat/completions)

# Check for errors in response
error=$(echo $response | jq -r '.error.message // empty')
if [[ -n $error ]]; then
    echo "Error: $error"
else
    # Extract and print the response
    echo $response | jq -r '.choices[0].message.content // "No response"'
fi

