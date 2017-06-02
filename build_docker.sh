#!/bin/bash

if [[ "$*" ]] ; then
	docker build -t epiceric/gcc-arm --build-arg EDITORPKG="$*" docker
else
	docker build -t epiceric/gcc-arm docker
fi
