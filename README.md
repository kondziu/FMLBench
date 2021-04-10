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

## Langton's ant

`benchmarks/langtons_ant.fml`

An ant moves on a world of square tiles. The ant has position on a specific tile and an orientation (up, down, left, right). The tiles are initiall all white, but each tile can be either black or white. The program runs for 201 steps. In each step the ant moves one tile according to the following rules.

- If the ant is on a while tile, it changes the tile's color to black, rotates clockwise and moves one tile forward.
- If the ant is on a black tile, it changes the tile's color to white, rotates counterclockwise and moves one tile forward.

The board and the ant are printed after each step. The world starts empty and expands whenever the ant moves to a new tile.

[[wiki]](https://en.wikipedia.org/wiki/Langton%27s_ant)

## Brainfuck interpreter

An implementation of the Brainfuck language executing a specific program.

The language contains 8 instructions `.,<>[]+-`, 7 of which are expressable in FML (FML cannot read from stdin, preventing it from implementing `,`). The interpreter has a memory of 512 integers and a memory pointer. The interpreter moves the pointer to the left and right (`<` and `>`), increments and decrements the values at the pointer (`+` and `-`), and prints out the value of a cell as ASCII (`.`). `[` and `]` imeplement loops: `[` checks if the value of the cell at the pointer is 0, and proceeds to a matching `]` if it is or executes the next statement if it isn't. `]` returns to the matching `[`.

In this implementation the memory consists of 512 32bit integers. The memory pointer is initially positioned in the middle.

The program executed by the benchmark prints out a poem in 429 instructions.

```
+++++ [ > +++++ [ > ++++ <- ] <- ]
+++++ [ > ++++++ <- ] > ++ <         
+++++ +++++                           

>> ++ ++                         .   
   ++ ++ +++                     .
   ++++ ++++                     .
<                                .
>  - - -                         .
   -----                         .
<                                .
>  ++ ++                         .
   - - -                         .
   --- ----- ---                 .
   ++  +++++  ++                 .
   --- -- --  ---                .
<<                               .
>  .  .  .                       .
>  ++++ +++ ++ +++ ++++          .
   - -- - - -- - - -- -          .
   +                             .
   ++ ++   +  +   ++ ++          .
<                                .
>  +                             .
   ---- --- ----                 .
   +    + +    +                 .
   --  -- --  --                 .
<<                               .
>  .  .  .  .  .  .  .           .
>  ++ ++ ++ ++                   .
   ++                            .
   -- -- -- --                   .
   - - - - - -                   .
   ++++ ++++ ++++                . 
             ----                .
<                                .
>  ++   +   +++   +   ++         .
   ---      ---      ---         .
   +  +++++  +  +++++  +         .
   -- ------ - ------ --         .
         +++++ +++ +++++         .
<<                               .
                                 .
>  . ..  .. . .. .. .            .
   ++++  ++ + ++ ++++            .
                                 .
   ----  -- - -- ----            .
>  +++      +     +++            .
   ---      -                    .
   ----------                   ..
   + + + +                      .
<<                              ..
```

[[wiki]](https://en.wikipedia.org/wiki/Brainfuck)