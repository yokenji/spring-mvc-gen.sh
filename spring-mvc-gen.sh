#!/bin/bash

# A maven archetype helper script.

# path to Java.
pathJava=/usr/lib/jvm/java-8-oracle

# This is the archetype template.
archetypeGroupId="com.mattheeuws.archetypes"
archetypeArtifactId="spring-mvc"
archetypeVersion="0.0.1-SNAPSHOT"
interactiveMode=false

# The requested parameters.
myGroupId=""
myArtifactId=""

usage() {
	echo "Usage: $0 [-g groupId] [-a artifactId ]" 1>&2; exit 1;
}

while getopts ":a:g:" opt; do
  case "${opt}" in
    a)
      myArtifactId=${OPTARG}
      ;;
    g)
      myGroupId=${OPTARG}
      ;;
    *)
      usage
      ;;
    esac
done

shift $((OPTIND-1))

if [ -z "${myArtifactId}" ] || [ -z "${myGroupId}" ]; then
  usage
fi

echo "Create a maven project with following options:"
echo "ArtifactId: " $myArtifactId
echo "GroupId: " $myGroupId

export JAVA_HOME=$pathJava

mvn archetype:generate \
    -DarchetypeGroupId=$archetypeGroupId \
    -DarchetypeArtifactId=$archetypeArtifactId \
    -DarchetypeVersion=$archetypeVersion \
    -DgroupId=$myGroupId \
    -DartifactId=$myArtifactId \
    -DinteractiveMode=$interactiveMode

# Change to the generated project directory.
cd "$PWD"
cd $myArtifactId

# Configure the project for Elcipse.
mvn eclipse:eclipse
