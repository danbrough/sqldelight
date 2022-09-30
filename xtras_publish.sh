#!/bin/bash

cd "$(dirname "$0")" 

[ -z "$SONATYPE_USER" ] && echo SONATYPE_USER not set && exit 1
[ -z "$SONATYPE_PASSWORD" ] && echo SONATYPE_PASSWORD not set && exit 1
[ -z "$SONATYPE_REPO_ID" ] && echo SONATYPE_REPO_ID not set && exit 1

if [ "$(uname)" = "Darwin" ]; then 
	
else
	./gradlew  publishAllPublicationsToSonatypeRepository
fi
