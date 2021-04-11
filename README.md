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

# Sudoku solver

A brute force sudoku solver. It starts from the top-left corner of the board, adds a number from 1-9 (in order) in the first available empty spot and checks whether the board is still valid. It continues until the end of the board and backtracks to if the board becomes invalid at any point.

The solver solves the following four puzzles.

```
8  |1 3|4        1|  6|435    85 |  1|  6    9 7| 5 |3  
 35|78 | 62       |  1|         7| 64|1        6|  3|9 5
47 |  6| 9      5 |47 |98       4| 7 |59       1| 2 | 4 
---+---+---    ---+---+---    ---+---+---    ---+---+---
   |   | 24      2| 8 |7 9    2  | 56|  4      8|5 7|6  
 1 |3 5| 8       8|7  |612    6  |1 9| 7     6 4| 9 |1 7
28 |   |        64| 1 | 5     7 1| 4 |  9     9 |   |8  
---+---+---    ---+---+---    ---+---+---    ---+---+---
 2 |6  | 39    91 |342|8 7     1 |9  |46     5 9|  6| 73
19 | 72|64      27|   | 9      96|  8|  7      2| 1 |   
  8|5 9|  1    6 3| 9 |5       7 |6  |  1       | 4 |2 9
```

[[wiki]](https://en.wikipedia.org/wiki/Sudoku)