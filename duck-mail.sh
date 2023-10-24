#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Duck Mail
# @raycast.mode silent


# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName duckmail raycast
# @raycast.needsConfirmation false


# Documentation:
# @raycast.description Generate and copy Duck mail private address.
# @raycast.author uzzal
# @raycast.authorURL https://raycast.com/uzzal


# For obtaining a token go to https://duckduckgo.com/email/settings/autofill and click "Generate Private Address"
# Open browser devtool and go to network tab. Check the request name "addresses".
# In the "Headers" section of the request you will find "Authorization". 
# Copy the value (Something like "Bearer xj2hdsvzghahyzzkoadsye|3560eaghafhpvedavozobctfbxtcih09zauqtahf6f")
# Paste only "xj2hdsvzghahyzzkoadsye|3560eaghafhpvedavozobctfbxtcih09zauqtahf6f" this part below
BEARER_TOKEN="<Your_duckmail_token>"


# Send the POST request and store the response in a variable
response=$(curl --fail --silent -X POST -H "Authorization: Bearer $BEARER_TOKEN" "https://quack.duckduckgo.com/api/email/addresses")
exit_code=$?

# Check if the curl request was successful (HTTP status code 200)
if [ $exit_code -eq 0 ]; then
  # Use jq to extract the "address" field and add "@duck.com" to it, and then print the updated value
  new_address=$(echo "$response" | grep -o '"address":"[^"]*' | awk -F '"' '{print $4"@duck.com"}')
  
  # Print the updated address
  echo "$new_address" | pbcopy

  echo "New email address: $new_address copied to the clipboard"
else
  echo "Request failed"
  exit 1
fi











