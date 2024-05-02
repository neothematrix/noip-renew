#!/bin/bash

USERNAME=""
PASSWORD=""
TOTP_SECRET=""

LOGDIR=$1
PROGDIR=$(dirname -- $0)

if [ -z "$LOGDIR" ]; then
    $PROGDIR/noip-renew.py "$USERNAME" "$PASSWORD" "$TOTP_SECRET" 2
else
    cd $LOGDIR
    $PROGDIR/noip-renew.py "$USERNAME" "$PASSWORD" "$TOTP_SECRET" 0 >> $USERNAME.log
fi
