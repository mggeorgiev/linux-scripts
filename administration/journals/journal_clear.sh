#!/bin/bash

sudo du -hs /var/log/journal/
ls -lath /var/log/journal/*/ | tail -n 2
journalctl --vacuum-time=100d
