#!/bin/bash
ESCAPED_PASSWORD=$(printf '%s\n' "$2" | sed -e 's/[\/&]/\\&/g')
sed -e "s/%UDI_EMAIL%/$1/" -e "s/%UDI_PASSWORD%/$ESCAPED_PASSWORD/" check-udi.side > parsed.side
npx selenium-side-runner -c "browserName=chrome goog:chromeOptions.args=[disable-infobars, headless]" parsed.side > result.txt 2>&1
rm parsed.side
if grep -q passed "result.txt"; then
  echo "Successfully scanned for appointments but did not find any"
  rm result.txt
  exit 0
else
  "Either found available appointments or failed script execution"
  cat result.txt
  rm result.txt
  exit 1
fi
