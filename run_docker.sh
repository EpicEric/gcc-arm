#!/bin/bash

IMAGE="$(docker ps -q -f ancestor=epiceric/gcc-arm)"

if [[ $IMAGE ]] ; then
	docker exec -ti $IMAGE /bin/bash entrypoint.sh
else
	if [[ "$1" ]] ; then
		SRCDIR="$( cd $1 && pwd )"
	else
		GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
		SRCDIR="$GITDIR/src"
	fi

	if [[ "$2" ]]; then
		docker run --rm -ti -v "$SRCDIR":/home/student/src --device="$2":/dev/ttyS0 epiceric/gcc-arm
	else
		docker run --rm -ti -v "$SRCDIR":/home/student/src epiceric/gcc-arm
	fi
fi
