#!/bin/bash

if [[ "$*" ]] ; then
	docker build -t epiceric/gcc-arm --build-arg EDITORPKG="$*" docker
else
	GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	docker build -t epiceric/gcc-arm $GITDIR/docker
fi
