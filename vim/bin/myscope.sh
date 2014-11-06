#!/bin/bash

# Get project location
PRJ_DIR=$(pwd)

# Create a working directory
if [ -d $PRJ_DIR/.myscope ]; then
    echo "Directory $PRJ_DIR/.myscope exists. Aborting."
    exit
else
    mkdir $PRJ_DIR/.myscope
    cd $PRJ_DIR/.myscope
fi

# Find files to be indexed
for EXT in "c" "h" "cpp" "hpp" "C" "H"; do
    find $PRJ_DIR -name "*.${EXT}" >> myscope.files
done

# Build cscope references
cscope -b -k -q -imyscope.files
