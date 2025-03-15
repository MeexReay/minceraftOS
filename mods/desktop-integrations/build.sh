#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/openjdk21
cp ../../version src/main/resources
./gradlew build
mv build/libs/*.jar build
mv build/*-sources.jar build/libs
mv build/*.jar ../build