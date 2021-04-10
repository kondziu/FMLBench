# FMLBench
Tests and benchmarks for FML

# Installing the reference

Install the reference implementation like this:

```
git clone https://github.com/kondziu/FML.git reference
cd reference
cargo build --release
cd ..
```

There are also VS Code build tasks to do this (`Download FML reference` and `Build FML reference`).

# Running benchmarks

Run the benchmarks using the reference implementation like this:

```bash
./run_benchmarks.sh
```

This runs 10 iterations of each benchmark using the reference implementation in `reference`.

To run all benchmarks using your implementation, specify paths to one or more FML executables as arguments, eg.:

```bash
./run_benchmarks.sh ~/Workspace/myFML/fml ~/Workspace/myOtherFML/fml
```

This runs 10 iteration of each benchmark with specified implementation plus the reference implementation.

The executed FML implementation must accept the following arguments: `run benchmarks/BENCHMARK.fml`.

The outputs of the benchmarks are written to `output/BENCHMARK.out` and the timing is written to `timing_log.csv`.

# Benchmarks

The suite consists of the following benchmarks.

