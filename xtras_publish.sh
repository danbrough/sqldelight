#!/bin/bash

cd $(dirname "$0")


[ -z "$SONATYPE_USER" ] && echo SONATYPE_USER not set && exit 1
[ -z "$SONATYPE_PASSWORD" ] && echo SONATYPE_PASSWORD not set && exit 1
[ -z "$SONATYPE_REPO_ID" ] && echo SONATYPE_REPO_ID not set && exit 1

#export
#export libs.sonatype.user=$SONATYPE_USER
#export libs.sonatype.password=$SONATYPE_PASSWORD
#OPTS="-Plibs.repository.id=https://s01.oss.sonatype.org/service/local/staging/deployByRepositoryId/$SONATYPE_REPO_ID \
OPTS="-PsignPublications -Plibs.repository.id=$SONATYPE_REPO_ID \
	-Plibs.sonatype.user=$SONATYPE_USER  -Plibs.sonatype.password=$SONATYPE_PASSWORD"

git submodule init
git submodule update

#cd kotlinx.team.infra
#./gradlew publishToMavenLocal || exit 1
#cd ..


if [ "$(uname)" = "Darwin" ]; then
  #need JAVA_HOME to be set
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home/
  ./gradlew $OPTS `cat mac_targets.txt `
  exit 0
fi

./gradlew $OPTS publishAllPublicationsToSonaTypeRepository
#./gradlew $OPTS publishToMavenLocal

