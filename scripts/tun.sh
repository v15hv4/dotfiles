#! /bin/bash

DEST=`echo $1 | cut -d: -f 1`
DEST_PORT=`echo $1 | cut -d: -f 2`
LOCAL_PORT=$2

ssh ${@:3} -f -N -L $LOCAL_PORT:localhost:$DEST_PORT $DEST
echo "Tunneling localhost:$LOCAL_PORT -> $DEST:$DEST_PORT".
