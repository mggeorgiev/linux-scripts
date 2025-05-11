#/bin/bash
journalctl --vacuum-time=2d
journalctl --vacuum-size=500M