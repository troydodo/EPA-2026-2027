#!/bin/bash
# lab04_cpu_count_3.sh
# Version 3: adds two commands from the Bash manual: 'trap' and 'printf'.

# trap: runs this function whenever the script exits (success or error)
cleanup() {
    printf "\n[trap] Script finished. Exit code: %d\n" "$?"
}
trap cleanup EXIT

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

# printf: formatted, aligned output
printf "%-20s %s\n" "cpuinfo count:" "$num_cpu"
printf "%-20s %s\n" "nproc count:" "$nproc_cpu"
printf "%-20s %s\n" "required:" "$required"

if [ "$num_cpu" -lt "$required" ]; then
    printf "ERROR: Only %d cores found, but %d are required.\n" "$num_cpu" "$required"
    exit 1
else
    printf "OK: %d cores found (required: %d).\n" "$num_cpu" "$required"
fi

# Explain what the chosen commands did (required by the lab sheet)
echo ""
echo "--- What the chosen commands did ---"
echo "printf: gives formatted, aligned output, so the results are easier to read than with plain echo."
echo "trap: runs a cleanup function on exit, so a final message and exit code are always reported, even after an error."
