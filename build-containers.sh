#!/usr/bin/bash
# Builds API
echo "Running API build in the background. Consult texture-replacer-api/build-container.log for details"
cd texture-replacer-api
./build-container.sh > build-container.log &
cd ..

# Waits on all child processes
echo "Waiting on child processes..."
wait