#!/bin/bash

echo "Reset build directory"
rm -rf build
mkdir build

for dir in */; do
    if [ "$dir" != "build/" ]; then
        echo "Building $dir mod..."
        cd "$dir"
        ./build.sh
        cd ..
    fi
done

cp fabric-api*.jar build/
