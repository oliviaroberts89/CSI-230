#!/bin/bash
accesslog=$1
ioc=$2
: > report.txt
grep -f "$ioc" "$accesslog" | cut -d' ' -f1,4,7 | tr -d '[' >> report.txt
