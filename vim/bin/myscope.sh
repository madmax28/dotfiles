#!/bin/bash

print_usage () {
    echo "Usage: myscope.sh <project path>"
}

# Parse arguments
if [ ! -d $1 ]; then
    print_usage
    exit
fi

# Get project location
cd $1
PRJ_DIR=$PWD

# Create a working directory
if [ -d $PRJ_DIR/.myscope ]; then
    echo "Directory $PRJ_DIR/.myscope exists. Rebuilding."
    rm -rf $PRJ_DIR/.myscope
fi
mkdir $PRJ_DIR/.myscope
cd $PRJ_DIR/.myscope

# Find files to be indexed
for EXT in "c" "h" "cpp" "hpp" "C" "H"; do
    find $PRJ_DIR -name "*.${EXT}" >> myscope.files
done

# Build cscope references
cscope -b -k -q -imyscope.files
