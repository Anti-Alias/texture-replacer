#!/usr/bin/bash

# Builds API container
echo "Running API build in the background. Consult asset-replacer-api/build-container.log for details"
cd asset-replacer-api
./build-container.sh > build-container.log &
cd ..

# Waits on all child processes
echo "Waiting on child processes..."
wait