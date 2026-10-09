#!/bin/bash
# lab04_cpu_count_2.sh
# Same as version 1, but prints a usage message if no argument is given.

# Prints how to use the script, then exits
usage() {
    echo "Usage: $(basename "$0") [MAX_NUM_CORES]"
    exit 1
}

# Check that an argument was supplied
if [ $# -lt 1 ]; then
    usage
fi

# Check that the argument is a positive integer
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "ERROR: '$1' is not a valid number."
    usage
fi

required=$1
num_cpu=$(grep "processor" /proc/cpuinfo | wc -l)
nproc_cpu=$(nproc)

echo "cpuinfo count: $num_cpu"
echo "nproc count:   $nproc_cpu"

if [ "$num_cpu" -lt "$required" ]; then
    echo "ERROR: Only $num_cpu cores found, but $required are required."
    exit 1
else
    echo "OK: $num_cpu cores found (required: $required)."
fi

