#!/bin/bash

REFERENCE_FML='reference/target/release/fml'
TIMING_LOG='timing_log.csv' 
OUTPUT_DIR='output'

function run_and_record_time {
    local command="$1"
    local benchmark="$2"
    local iteration="$3"
    local result=

    mkdir -p "$OUTPUT_DIR"
    local output_file=$(mktemp "$OUTPUT_DIR/$(basename $benchmark .fml).XXX.out")
    
    echo "STARTING [$iteration] \"$command\" run \"$benchmark\" > $output_file"
    
    start_time_in_nanos=$(date +%s%N)
    
    "$command" run "$benchmark" >> "$output_file"

    diff <(grep -e '// >' < "$benchmark" | sed 's/\/\/ > \?//') "$output_file" > "$output_file.diff"

    if [ "$?" -eq 0 ]
    then result="true"
    else result="false"
    fi
    
    end_time_in_nanos=$(date +%s%N)
    elapsed_time_in_nanos=$(($end_time_in_nanos - $start_time_in_nanos))
    elapsed_time_in_millis=$(($elapsed_time_in_nanos/1000/1000))

    echo "$command, $(basename $benchmark .fml), $iteration, $elapsed_time_in_millis, $result, $output_file" >> "$TIMING_LOG"
}

if [ ! -e "$TIMING_LOG" ]
then
    echo "FML implementation, benchmark, iteration, millis, correct, ouput file" > "$TIMING_LOG"
fi

for benchmark in benchmarks/*.fml 
do    
    for iteration in $(seq 1 10)
    do
        for implementation in "$REFERENCE_FML" "$@"
        do
            run_and_record_time "$implementation" "$benchmark" $iteration
        done     
    done
done
