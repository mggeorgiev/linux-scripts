#/bin/bash
ssh georgiem@apex -t "sudo df -h && echo 'Backup size' && du -hx /u01/app/oracle/fast_recovery_area/XE/backupset/"
