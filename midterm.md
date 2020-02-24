
# Computer Architecture Midterm

## Big O notation
- Big O notation describes worst case performance of an algorithm.
- Concerned with the rate of growth of the execution time given variance in input size
- N is the input size of the data

> ### O(1): Constant
> Algorithm executes in same time regardless of the input size (most efficient). 

> ### O(N): Linear
> Algorithm execution time grows linearly with the input size.

> ### O(N<sup>2</sup>): Quadratic
> Algorithm execution time grows proportionaly to the square of the input size. Commonly seen with algorithms that contain nested iterations where the degree of N describes the depth of the nested iteration.

> ### O(2<sup>N</sup>): Exponential
> Algorithm execution time doubles for additional inputs (least efficient).

> ### O(log N) O(ln N): Logarithmic
> Algorithm execution time follows logarithmic curve independant of base log. An incease in the order of magnitude of the input size will double the execution time. For example, binary search where each iteration reduces the amount of data to search by half

### Reduction Rules
1. Product: `f(x)f(x) = O(g1(x)g2(x))`
2. Sum: `f1(x) + f2(x) = O(max(g1(x),g2(x)))`
3. Scaling: `O(kg1(x)) = O(g1(x))`

### Application to Instruction Set Cycles
- State of instruction set details how an execution is divided by clock cycle primitives

> Sample instruction cycle for a particular CPU has **5** states:
> 1. Fetch
> 2. Decode
> 3. Execute ALU Operation
> 4. Access Memory
> 5. Write to Destination Register</br>
> 
> Each state require a clock cycle each for a total of 5 *clock* cycles for each *execution* cycle

- Each instruction has different execution requirements:

> LOADx: Load a register from a memory location specified using indexed addressing.
> 1. Fetch
> 2. Decode
> 3. Execute ALU Operation (add base + offset to get memory address)
> 4. Access Memory (read contents from memory)
> 5. Write to Destination Register (write the value to register) </br>
> 
> Requires all 5 states so LOADx will take 5 clock cycles

> LOADi: Load a register from an immediate value encoded in the instruction.
> 1. Fetch
> 2. Decode
> 3. <del>Execute ALU Operation
> 4. <del>Access Memory
> 5. Write to Destination Register (write the value to register) </br>
> 
> Requires only 3 states since a specified value is being directly written to the register. so LOADi will take 3 clock cycles

- CPI (Cycles per Instruction): describes the clock cycles required for each instruction.
- CPI<sub>avg</sub> describes the sum of all CPIs divided by the total number of instructions

## Performance Metrics

The following equation determines the total number of cycles in a program (n x CPI) and divides it by the number of seconds (T) to give a metric for how long it will take a CPU to execute a set of instructions (in seconds):

`Execution Time (T) = n * CPI * T`

Where n is the number of instructions in the program, CPI is the average CPI of the program and T is clock period of the CPU. Average CPI is formulated from the assumption that each *type* of instruction yields an equal weight of all instructions across the whole program. To understand this we analyze the CPI formula: `CPI = (Σ (In * Cn)) / Σ In` where `In` is the instruction count for instruction `n` and `Cn` is the cycle count for instruction `n`. If `In` is constant across all instructions `n` we can write: `Average CPI = (I * Σ Cn) / (I * n) = Σ Cn / n`. This is the basis behind average CPI. The instructions are assumed to have equal instruction counts weight `I` which is a constant across all instruction types. Given this, we can see that a distribution of instruction counts that have a a large disparity will yield large average CPI error from the true value. For example, a program executing LOADx 500 times and a JGE twice will have a large average error since the average will assume each instruction *type* will execute once and so the execution cycles for JGE will have equal weight to the execution cycles for LOADx even though JGE only executes twice and LOADx executes 500 times.

We can reduce CPI by:
1. Von Neumann architecture with one memory for instructions and data which reduces data fetch redundancy
2. Pre-fetch: overlap fetch of next instruction with last execution stage of current instruction. Typically good to prefetch next instruction while a register is being written to (since it doesn't use memory or the bus). For example, pre-fetch doesn't work for last execution states of STORE since the memory/bus is busy storing a value.

General equation for computing percentage speed-ups

`% Speed-Up = 100 * (prev-curr) / curr`

- Harvard Architecture introduces a seperate data memory and bus for loading and storing data. This allows for pre-fetches for STORE instructions. However pre-fetches still cannot happen during conditional jumps since the next instruction is unknown.

`MIPS = IPS / 1e6`

Where IPS is instructions per second.

Alternatively:

`MIPS = f / CPI * 1e6`

Derived from execution time T. This representation shows the functional relationship of performance parameters `f` and `CPI` to the throughput. Notably the instruction count `IC` is missing which makes `MIPS` as a performance metric worse than response time `T`. 

- MIPS tells us how fast the CPU is processing instructions
- Execution time tells us how fast a CPU can finish a set of instructions

> Two compilers A and B
> 1. Compiler A: 2800 MIPS | Execution Time: 2.5e-3 s
> 2. Compiler B: 3200 MIPS | Execution Time: 3.75e-3 s
> 
> According to MIPS compiler B is *faster* in the sense that it is processing more instructions per second. This is known as *system throughput*. However compiler A is *faster* in the sense that its execution time is less, meaning the compiler A finishes executing sooner than compiler B. This is known as *system response time* Thus it is important to be concise when describing processing speed.

In summary:
- MIPS is a measure of *system throughput*, how many instructions are executed per unit time.
- Execution time (T) is a measure of the *system response time* or the time delay to complete a certain task in seconds.

