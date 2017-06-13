#!/usr/bin/env bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
MESSAGE="Site rebuild $(date)"

# Build the project.

RScript -e 'blogdown::build_site()'


# Go To Public folder
pushd public
# Add changes to git.
git add .

# Commit changes.
git commit -m "$MESSAGE"

# Git push and come back to main working dir.
git push
popd
