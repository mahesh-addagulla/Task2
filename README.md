# Read data from TFL Open API
Linux Shell Script is generate delimited text file with required headers as an output.
Step1- Ensure prereqisite softwares/libraries/tools are installed on UNIX (Linux) server
E.g curl to read API, jq (It is versatile tool in Linux that allows you to parse and manipulate JSON data right from your command line) 
Parameterise the API value
Check the output file existance and create if not present with required headers

Extract the data from API using curl command
Capture the API response and parse it with jq 
Add current_timestamp explicitly to header
Appends the results to output file
