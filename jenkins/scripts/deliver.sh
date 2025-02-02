#!/bin/bash

echo 'The following Maven command installs your Maven-built Java application'\n
echo 'into the local Maven repository, which will ultimately be stored in'\n
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'\n
echo 'volume).'\n
# set -x
mvn -Denforcer.skip=true jar:jar install:install help:evaluate -Dexpression=project.name
# set +x

echo 'The following complex command extracts the value of the <name/> element'\n
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'\n
# set -x
NAME=`mvn help:evaluate -Denforcer.skip=true -Dexpression=project.name | grep "^[^\[]"`
# set +x

echo 'The following complex command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
# set -x
VERSION=`mvn help:evaluate -Denforcer.skip=true -Dexpression=project.version | grep "^[^\[]"`
# set +x

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
# set -x
java -jar target/${NAME}-${VERSION}.jar
