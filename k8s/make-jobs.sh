#!/bin/bash

# Get the list of tests
tests=($(npx playwright test --list | grep -oP '(?<=› ).*?(?= ›)' | sort))

echo "Creating jobs for the following tests:"
printf '%s\n' "${tests[@]}"

# Loop over the tests
for index in "${!tests[@]}"
do
  test=$(printf '%q' "${tests[$index]}")
  # Replace $ITEM and $INDEX in the template and create a new job file
  sed -e "s/\$ITEM/$test/" -e "s/\$INDEX/$index/" ./k8s/pw-job-tmpl.yaml > ./k8s/jobs/job-$index.yaml
done