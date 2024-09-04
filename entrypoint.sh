#!/bin/sh -l

cfn-lint -v
echo

echo "Running cfn lint against cloudformation directory"
cfn-lint -i E0000 -I "/github/workspace/cloudformation/**/*.y*ml" > cloudformation_scan.txt  2>&1 

awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }' cloudformation_scan.txt
echo

echo "Running cfn-lint against SAMtemplates directory"
cfn-lint -I "/github/workspace/SAMtemplates/**/*.y*ml" > samtemplates_scan.txt 2>&1 

awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'  samtemplates_scan.txt
echo

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
