#!/bin/bash

git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch .env" HEAD
git push -f
git log --oneline
#git rebase -i main