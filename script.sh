#!/bin/bash

set -e

# Remember to set the GH_TOKEN environment variable in the travis configuration page
# DO NOT SAVE it into the repository or into this file

TARGET_BRANCH="pushes"
GIT_USERNAME="Travis CI"
GIT_EMAIL="travis@example.com"
REPOSITORY="langmark/langmark"
#GH_TOKEN="the token should not be visible in the repository..."


## END OF THE CONFIGURATION SECTION


# Configure Git to use the given username
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"

# Add the remote url using the specified token
git remote add upstream "https://$GH_TOKEN@github.com/${REPOSITORY}.git"

# Execute the command and measure the total time
# Awk use is mandatory because travis doesn't have bc
_START=$(date +%s.%N)
./langmark.py
_END=$(date +%s.%N)
TOTAL_TIME=$(awk "BEGIN {printf \"%.3f\",${_END}-${_START}}")

git reset --hard HEAD
git fetch upstream
git checkout -b $TARGET_BRANCH upstream/$TARGET_BRANCH

ls -l
find -regex '\./[0-9]+\.json'
mv $(find -regex '\./[0-9]+\.json') results/
ls results > results.txt

git add results.txt results

git commit --allow-empty -am "Update from TravisCI" -m "On date: $(date)" -m "Execution time: $TOTAL_TIME"
# The output of this command is not shown because it may contain the access token
git push upstream $TARGET_BRANCH 2>/dev/null >/dev/null
