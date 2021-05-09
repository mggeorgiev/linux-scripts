#!/bin/bash

journalctl --disk-usage
journalctl --vacuum-size=200M
journalctl --list-boots