#!/bin/sh
set -eu

test -f index.html
test -f Dockerfile
test -f Jenkinsfile

grep -q 'CI/CD Pipeline' index.html
grep -q 'Version 2' index.html
grep -q 'FROM nginx:alpine' Dockerfile

echo 'PASS: Version 2 website tests successful.'