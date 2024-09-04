#!/bin/sh -l


cfn-lint -I "/github/workspace/cloudformation/**/*.y*ml" 2>&1 | awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'
cfn-lint -I "/github/workspace/SAMtemplates/**/*.y*ml" 2>&1 | awk '/Run scan/ { print } /^[EW][0-9]/ { print; getline; print }'



