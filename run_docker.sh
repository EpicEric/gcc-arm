#!/bin/bash

if [[ "$1" ]] ; then
	SRCDIR="$( cd $1 && pwd )"
else
	GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	SRCDIR="$GITDIR/src"
fi

if [[ "$2" ]]; then
	docker run -ti -v "$SRCDIR":/home/student/src --device=$2:/dev/ttyS0 epiceric/gcc-arm
else
	docker run -ti -v "$SRCDIR":/home/student/src epiceric/gcc-arm
fi
