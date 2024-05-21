#!/bin/bash

# # Check if jq is installed to process the JSON file
# if ! command -v jq &> /dev/null; then
#     echo "jq is not found, please request you to install jq to proceed."
#  #Install curl and jq library

# sudo apt-get update
# sudo apt install curl jq
# fi

# Parameterise the API 
TFL_URL="https://api.tfl.gov.uk/Line/Mode/tube/Status"

# Output Delimited text file

TFLTubeLine_Status="TFLTubeLine_Status.txt"

# Vlidate if output tubereport text file presence and generate with header columns if it does not exists 
if [ ! -f "$TFLTubeLine_Status" ]; 
then
    echo "current_timestamp,line,status,disruption_reason" > "$TFLTubeLine_Status"
fi

# Fetch current timestamp
current_timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Extract data from API by using curl command
TFL_URL_Response=$(curl -s "$TFL_URL")

# Check if the response of API is not empty
if [ -n "$TFL_URL_Response" ]; then
    # Parse JSON API response and append to the genetated output file
    echo "$TFL_URL_Response" | jq -r --arg current_timestamp "$current_timestamp" '
        .[] | 
        .lineStatuses[] | 
        [$current_timestamp, .lineId, .statusSeverityDescription, (.reason // "No disruption reason")] | 
        @csv' >> "$TFLTubeLine_Status"
else
    echo "Unable to fetch data from the $TFLTubeLine_Status API"
fi