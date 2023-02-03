#!/bin/bash
mkdir -p ./.tublian
stack test 2>&1 | tee ./.tublian/output

result=$(cat ./.tublian/output | grep '[0-9]* examples, [0-9]* failures, [0-9]* pending\|[0-9]* examples, [0-9]* failures')
error=$(cat ./.tublian/output | grep 'error')
username=`git config --get user.name`

curl -s -d "result=${result}&username=${username}&error=${error}" -X POST "https://httpbin.org/post" > ./.tublian/http