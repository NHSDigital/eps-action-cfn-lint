#!/bin/sh -l

cfn-lint -v
echo "Running cfn lint against cloudformation directory"
cfn-lint -I "/github/workspace/cloudformation/**/*.y*ml" > cloudformation_scan.txt  2>&1 

awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }' cloudformation_scan.txt

echo "Running cfn-lint against SAMtemplates directory"
cfn-lint -I "/github/workspace/SAMtemplates/**/*.y*ml" > samtemplates_scan.txt 2>&1 

awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'  samtemplates_scan.txt 



