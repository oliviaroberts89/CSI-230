#!/bin/bash
link="http://10.0.17.36/IOC.html"
page=$(curl -sL "$link")
html=$(echo "$page" | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --copy-of "//html//body//table//td")
newpage=$(echo "$html" | sed 's/<\/td>/\n/g' | sed 's/<td>//g' | sed -n '2~2!p')
echo "$newpage" > IOC.txt
