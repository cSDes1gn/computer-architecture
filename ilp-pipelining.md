# Instruction Level Parallelism: Pipelining

The goal of pipelining is to issue instructions for every clock cycle (1 CPI). This is hard to achieve because different instructions have different dependancies and control (branching) hazards.

> A **hazard** is a problem with the CPU instruction pipeline where the next instruction cannot execute in the following clock cycle.

Pipelining architectures differ depending on the underlying computer architecture:

> **Complex Instruction Set Computer (CISC)** has many specialized instructions (ie x86). Requires smart compilers to optimize code and typically has less instructions than RISC programs but larger CPIs

> **Reduced Instruction Set Computer (RISC)** has a small instruction set (ie ARM or Advanced RISC Machine). Restricted addressing mode options. Instruction set focused on transistor optimization for faster execution speed. Smaller CPI but more instructions required over CISC to accomplish similar tasks.

| CISC (x86)| RISC (ARM)    | 
| -------------|:-------------|
| *DJNZ*| *SUB* |
|       | *BNZ* |
| Decrement a register and jump if not zero | Decrement a register then jump if not zero|

RISC become popular because of its simplified compilers nd simplified processor implementation. However since RISC programs had more instructions per program than CISC in general it needed to have a faster instruction execution time. This is where pipelining comes in.

## Pipelining Processor

Processors are considered to execute 1 instruction at a time and completely finishing before executing the next.

>**Pipelining processors** are organized to execute an assembly line of instructions, executing in parallel even though the instructions are at different execution stages.

### Operation
1. Breakdown each instruction into its sequence of stages.
2. Use a clock to move all instructions in the processor to the next stage
3. Pass stages of an instruction down a pipeline. Each buffer within the pipeline is responsible for one specific task. This allows for instruction level parallelism. (ie fetch next and execute current in same clock cycle)
4. Result is that hardware is always busy.

### Classic 5-Stage Pipeline
1. **Instruction Fetch**: grab instruction from memory
2. **Instruction Dispatch**: decode and get register/immediate operands
3. **Execute**: ALU operations
4. **Memory Access**: read/write data from/to memory
5. **Writeback**: updates registers

Steps 3-5 may not ne required by all instructions however for a pipelining architecture we must have an equal number of stages for all instructions.

Datapath is organized as a pipeline (sequence of stages) where each stage takes a clock cycle each. Note that the clock cycle can only be as fast as the slowest stage along the pipeline. For the classic 5-stage pipeline this means each instruction will take 5 clock cycles from start to end.

Each stage in the pipeline is a buffer with connections to stages preceeding and proceeding itself. Information needed at a later stage is passed through the pipeline.

Due to the rigid nature of the pipeline it restricts addressing modes since the ALU operation cannot be moved in front of memory access for indirect addressing computations.

> **Harvard architecture** splits cache for instruction memory and data memory. This is vital in pipelining since memory and instruction fetch must operate in parallel. The same memory cannot be accessed in parralel.

### CPI performance Benefits

If 3 instructions are processed by the 5-stage pipeline then the net cycles to complete these 3 instructions is 7. The general equation follows:

`C = (n-1) + S`

Where C is the cycles of execution, n is the number of instructions being added to the pipeline in the observation window and S is the number of stages defined by the pipeline. 

In a perfect world we can see that as the number of instructions added exceed the stages in the pipeline we complete 1 instruction every cycle which is the goal of instruction level parallelism.
