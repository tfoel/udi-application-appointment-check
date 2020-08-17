#!/bin/bash
if [ $# -ne 3 ]; then
    echo "Use as: ./check.sh <email> <password> <check limit>"
    exit 2
fi
ESCAPED_PASSWORD=$(printf '%s\n' "$2" | sed -e 's/[\/&]/\\&/g')
sed -e "s/%UDI_EMAIL%/$1/" -e "s/%UDI_PASSWORD%/$ESCAPED_PASSWORD/" -e "s/%CHECK_LIMIT%/$3/" check-udi.side > parsed.side
npx selenium-side-runner -c "browserName=chrome goog:chromeOptions.args=[disable-infobars, headless]" parsed.side > result.txt 2>&1
rm parsed.side
if grep -q "Assertion failed" "result.txt"; then
  echo "UDI appointment is available. Quick, before it is taken!"
  rm result.txt
  exit 1
elif grep -q passed "result.txt"; then
  echo "Successfully scanned for appointments but did not find any."
  rm result.txt
  exit 0
elif grep -q TimeoutError "result.txt"; then
  echo "UDI pages did not react within timeout boundaries."
  rm result.txt
  exit 0
else
  echo "Script execution failed during execution."
  cat result.txt
  rm result.txt
  exit 2
fi
