#!/bin/bash

# Define the Input and Output files
source_json_file="/home/adminsree/kpmg-task2/Task2-Test.json"
#tubereport_csv_file="/home/adminsree/kpmg-task2/TubeReport.csv"
tubereport_csv_file="/home/adminsree/kpmg-task2/TubeLineReport_output.txt"

# Get the current timestamp 
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# # Check if jq is installed to process the JSON file
# if ! command -v jq &> /dev/null; then
#     echo "jq is not found, please request you to install jq to proceed."
#     exit 1
# fi

#Install Json parsor jq in ubuntu
#sudo apt install jq

# Check if the source input  file is present and able to read
if [ ! -r "$source_json_file" ]; then
    echo "Error: Cannot read input file $source_json_file"
    exit 1
fi

echo "Source Input file path:" $source_json_file 

# Vlidate if output tubereport csv file presence and generate if it does not exists with header
if [ ! -f "$tubereport_csv_file" ]; then
    echo "current_timestamp,line,status,disruption_reason" > "$tubereport_csv_file"
fi


# Parse the JSON file with jq processor and read each line and append the mentioned/neccessary columns to the output tubereport file
jq -c '.[]' "$source_json_file" | while read -r line; do  
    current_timestamp=$(get_timestamp)
    line_name=$(echo "$line" | jq -r '.name')
    #Print the line,  status description, disruption reason
    echo "$line" | jq -c '.lineStatuses[]' | while read -r status; do
        status_description=$(echo "$status" | jq -r '.statusSeverityDescription')
        disruption_reason=$(echo "$status" | jq -r '.reason // empty')
        echo "$current_timestamp,$line_name,$status_description,$disruption_reason" >> "$tubereport_csv_file"
    done
done