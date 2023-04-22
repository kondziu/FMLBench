#!/bin/bash

# Locate this script on disk to use as root.
ROOT_DIR=$(dirname $(readlink -f "$0"))

TIMING_LOG='timing_log.csv'
HEAP_LOG_DIR='heap_log'
HEAP_SIZE=100 #MiB

function run_and_record_heap_events {
    local command="$1"
    local benchmark="$2"
    local result=

    mkdir -p "$HEAP_LOG_DIR"
    local log_file="$HEAP_LOG_DIR/$(basename $benchmark .fml):${command//\//\\}.csv"

    echo "STARTING \"$command\" run --heap-size $HEAP_SIZE --heap-log \"$log_file\" \"$benchmark\""

    "$command" run --heap-size "$HEAP_SIZE" --heap-log "$log_file" "$benchmark" >/dev/null
}

function run_and_record_time {
    local command="$1"
    local benchmark="$2"
    local iteration="$3"
    local result=

    echo "STARTING [$iteration] \"$command\" run \"$benchmark\""

    start_time_in_nanos=$(date +%s%N)

    local reference="$(grep -e '// >' < "$benchmark" | sed 's/\/\/ > \?//')"
    local output="$("$command" run "$benchmark")"

    diff -u <(echo "$reference") <(echo "$output")

    if [ "$?" -eq 0 ]
    then result="true"
    else result="false"
    fi

    end_time_in_nanos=$(date +%s%N)
    elapsed_time_in_nanos=$(($end_time_in_nanos - $start_time_in_nanos))
    elapsed_time_in_millis=$(($elapsed_time_in_nanos/1000/1000))

    echo "$command, $(basename $benchmark .fml), $iteration, $elapsed_time_in_millis, $result" >> "$TIMING_LOG"
}

if [ ! -e "$TIMING_LOG" ]
then
    echo "FML implementation, benchmark, iteration, millis, correct" > "$TIMING_LOG"
fi

for benchmark in "$ROOT_DIR/benchmarks/"*.fml
do
    for iteration in $(seq 1 10)
    do
        for implementation in "$@"
        do
            run_and_record_time "$implementation" "$benchmark" $iteration
        done
    done
done

for benchmark in "$ROOT_DIR/benchmarks/"*.fml
do
    for implementation in "$@"
    do
        run_and_record_heap_events "$implementation" "$benchmark"
    done
done
