#!/bin/bash
USER=

LOGDIR=/var/log/noip-renew/$USER
INSTDIR=/usr/local/bin
INSTEXE=$INSTDIR/noip-renew-$USER.sh
CRONJOB="30 0 * * *   $USER    $INSTEXE $LOGDIR"
NEWCJOB="30 0 $1 $2 *   $USER    $INSTEXE $LOGDIR"
crontab -u $USER -l | grep -v '/noip-renew*' | crontab -u $USER -
if [[ $3 = "True" ]]; then
    ( crontab -u $USER -l; echo "$NEWCJOB") | crontab -u $USER -
else
    (crontab -u $USER -l; echo "$CRONJOB") | crontab -u $USER -
fi

exit 0
