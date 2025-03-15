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

curl -o build/fabric-api.jar https://cdn.modrinth.com/data/P7dR8mSH/versions/IXeiAH6H/fabric-api-0.118.5%2B1.21.4.jar
