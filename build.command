#/usr/bin/env bash

function build_for {
    echo "Building for $1"
    
    xcrun xcodebuild clean build -quiet -scheme DynamicUI -destination generic/platform="$1"
    
    if [ $? -eq 0 ]; then
        echo -n "Build for $1 succeeded"
    else
        echo -n "Build for $1 failed"
        exit 1
    fi
}

build_for "iOS"
build_for "tvOS"
build_for "xrOS"
build_for "watchOS"
build_for "macOS"

exit 0