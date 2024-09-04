#!/bin/sh -l

# this is run from a github action
# the workspace folder from the github action will be mounted at /github/workspace so we are going to check files in there

cfn-lint -v
echo

# we ignore error E0000 which is no file exists as there may not be a cloudformation directory

echo "Running cfn lint against cloudformation directory"
cfn-lint -i E0000 -I "/github/workspace/cloudformation/**/*.y*ml" > cloudformation_scan.txt  2>&1 

# display what files we scanned and any errors or warnings with surrounding lines for context
awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }' cloudformation_scan.txt
echo

echo "Running cfn-lint against SAMtemplates directory"
cfn-lint -I "/github/workspace/SAMtemplates/**/*.y*ml" > samtemplates_scan.txt 2>&1 

# display what files we scanned and any errors or warnings with surrounding lines for context
awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'  samtemplates_scan.txt
echo

# exit with error if there were errors from cfn-lint
if grep -q '^[EW][0-9]' 'cloudformation_scan.txt'
then
    echo "Errors were found"
    exit 1
fi

if grep -q '^[EW][0-9]' 'samtemplates_scan.txt'
then
    echo "Errors were found"
    exit 1
fi

echo "No errors found"
