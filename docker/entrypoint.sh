#!/bin/bash
set -e

if [[ "$*" ]] ; then
	su - student -c "$*"
else
	su - student 
fi
