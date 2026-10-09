#!/bin/bash
# lab04_cpu_count.sh
# Checks that this VM has at least $1 CPU cores.
# Usage: ./lab04_cpu_count.sh 4

# Required number of cores, passed by the user as the first argument
required=$1

# Method 1: search cpuinfo for "processor" lines and count them
num_cpu=$(grep "processor" /proc/cpuinfo | wc -l)

# Method 2: nproc (preferred, cgroup-aware), shown for comparison
nproc_cpu=$(nproc)

echo "cpuinfo count: $num_cpu"
echo "nproc count:   $nproc_cpu"

# Print an error if there are fewer cores than required, otherwise OK
if [ "$num_cpu" -lt "$required" ]; then
    echo "ERROR: Only $num_cpu cores found, but $required are required."
    exit 1
else
    echo "OK: $num_cpu cores found (required: $required)."
fi

