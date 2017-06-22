#!/bin/bash

GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$*" ]] ; then
	docker build -t epiceric/gcc-arm --build-arg EDITORPKG="$*" $GITDIR/docker
else
	docker build -t epiceric/gcc-arm $GITDIR/docker
fi
