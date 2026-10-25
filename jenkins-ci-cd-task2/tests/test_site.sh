#!/bin/sh
set -eu

test -f index.html
test -f Dockerfile
test -f Jenkinsfile

grep -q 'CI/CD Pipeline' index.html
grep -q 'Version 1' index.html
grep -q 'FROM nginx:alpine' Dockerfile

echo 'PASS: Site files and required content are present.'
