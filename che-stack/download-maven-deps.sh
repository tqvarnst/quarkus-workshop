#!/bin/bash
# Copyright (c) 2018 Red Hat, Inc.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
#

set -e
set -u

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

##
# Clone and run `mvn clean package` on a repository, removing all
# downloaded files after completion. Used to download dependencies
# to the local maven repository.
#
# params:
# ${1} - Repository to download
# ${2} - branch/tag to check out
##
git_clone_and_build() {
  BRANCH=${1}
  cd "${HOME}"
  CURRENT_FOLDER=$(pwd)
  mkdir -p tmp-folder
  wget -qO tmp.zip "https://github.com/quarkusio/quarkus-quickstarts/archive/${BRANCH}.zip"
  unzip tmp.zip -d tmp-folder
  pushd tmp-folder/quarkus-quickstarts-${BRANCH}
  ./mvnw -f getting-started/pom.xml quarkus:list-extensions
  for qs in $(ls */pom.xml | sed "s/\/pom.xml//g" | grep -v hibernate-orm)
  do
    ./mvnw -B -f ${qs}/pom.xml package
  done
  #cd tmp-folder/quarkus-quickstarts-${BRANCH} && ./mvnw -f getting-started/pom.xml quarkus:list-extensions && ./mvnw verify -f getting-started/pom.xml && ./mvnw -B clean package -DskipTests
  popd
  rm -rf tmp-folder
}

QUARKUS_VERSION=${1}
echo "Downloading quickstart for Quarkus version: $QUARKUS_VERSION"
git_clone_and_build $QUARKUS_VERSION
