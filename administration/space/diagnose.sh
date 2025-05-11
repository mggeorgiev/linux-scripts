#!/bin/bash

sudo du -sh
sudo lsof / | grep deleted
df -h
sudo apt-get autoremove --purge
sudo apt-get autoclean
sudo du -hsx /* | sort -rh | head -n 40
sudo du -hsx /var/* | sort -rh | head -n 40

# Where large files are 
# du -k: Displays disk usage for files and directories in kilobytes.

# sort -n -r: Sorts the output numerically in reverse order (biggest first).

# head: Shows the first ten lines of the sorted output.
# du -k | sort -n -r | head
