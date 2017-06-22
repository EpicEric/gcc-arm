#!/bin/bash

if [[ "$1" ]] ; then
	SRCDIR="$( cd $1 && pwd )"
else
	GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	SRCDIR="$GITDIR/src"
fi

docker run -ti -v "$SRCDIR":/home/student/src epiceric/gcc-arm
