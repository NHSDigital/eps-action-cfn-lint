#!/bin/sh -l

cfn-lint -v
echo "Running cfn lint against cloudformation directory"
cfn-lint -I "/github/workspace/cloudformation/**/*.y*ml" 2>&1 | awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'

echo "Running cfn-lint against SAMtemplates directory"
cfn-lint -I "/github/workspace/SAMtemplates/**/*.y*ml" 2>&1 | awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'



