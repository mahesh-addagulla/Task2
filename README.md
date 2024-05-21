# Read data from JSON file.
Linux Shell Script is built to read data from JSON file and generate delimited text file as an output.
Step1- Ensure prereqisite softwares/libraries/tools are installed on UNIX (Linux) server
E.g jq (It is versatile tool in Linux that allows you to parse and manipulate JSON data right from your command line) 
Parameterise the source input file and check its validity
Check the output file existance and create if not present with required headers

Read the input JSON file data using jq and loop in until all lines are read
Parse it and extract required columns i.e line, status, disruption_reason
Add current_timestamp explicitly to header
Appends the results to output file
