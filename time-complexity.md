# Algorithm Time-Complexity Performance & Computer Architecture

*What is the difference (if any) between these statements:*
1. *The program has an infinite execution time.*
2. *The program has an indefinite execution time.*
 
>Infinite execution time means a program will never complete. Indefinite execution time means the completion time is unknown.

## Towers of Hanoi Algorithm

*Is this an undecided problem? Why?*

>Undecidable Problem: in computational theory, an undecidable problem cannot yield an accurate yes/no result by a computer algorithm. The halting problem is an example of such which asks the time at which a program will finish executing. The towers of hanoi problem can be calculated and so its a decidable problem by computational theory.

*What is the big-O complexity of the solution?*

>Based on the complexity suggestion of 2<sup>n</sup>-1, the big-O complexity of solving the towers of hanoi for an input of n disks would be O(max(2<sup>n</sup>,-1)) or O(2<sup>n</sup>)

*How many operations does the 64-disk version of the problem require?*

>The number of operations required for 64 disks would be 2<sup>64</sup>-1 or approximately `1.8446744e19`

*How fast would a compter have to perform each operation to complete the 64-disk solution in a day?*

> In order for a computer to achieve `1.8446744e19` operations in the span of a day or `86400` seconds it would have to processing at `1.8446744e19 ins / 86400 sec` or `2.1350398e+14 ins/sec` which is 214 trillion instructions per second. The fastest CPU we have available is an AMD Piledriver based FX-8370 chip which has a clock speed of `8.723 GHz` or the theoretical ability of performing `T = 1 / 8.723e9 = 1.1463946e-10 sec` and `1 ins / 1.1463946e-10 sec = 8722999916.43 ins/sec` which is just the CPU frequency in (Hz). Using performance analysis: `% Increase = 100% * (8722999916.43 ins/sec - 2.1350398e+14 ins/sec) / 8722999916.43 ins/sec = 24474.98 % increase`. So we see that we are not even close to being capable of solving this problem in a day via modern computing.

*If a computer could complete an operation in once CPU clock cycle, what CPU clock frequency would be needed to complete this operation in a day*

> From previous answer the clockspeed of the CPU that is capable of completing this problem in a day would have to be `2.135e14 Hz` or `214 THz`.

*Based on the answer given above, given today's typical CPU clock frequencies, is completing the 64-disk solution tractable or intractable?*

> Tractable solution: A problem is said to be tractable if there is an algorithm that, given an input n, can solve the problem in O(n<sup>c</sup>), where c is a constant that depends that problem. However, intractable problems allows exponential complexity versus input increase (O(c<sup>n</sup>)). This problem therefore is intractable since the time complexity of the towers of hanoi is O(2<sup>n</sup>)

*Under what condition does increasing the processor	clock frequency	by a factor of X also result in	a factor of	X increase in the size of a problem	that can be	computed tractably? Describe a problem that can	be solved with an algorithm that meets the condition.*

> Algorithms with linear complexity O(n) will result in a linearly scaled increase in problem size `X` in time `t` if the computer processor speed is scaled by a factor of `X`. For example iterating through a list of items is of linear time complexity. For example:
>```c
>sum = 0;
>// initialize n, and x; x is an array of n elements.
>for (i=0; i<n; i=i+1)
>      sum += x[i];
>end
>average = sum/n;
>```

## Computer Architecture & Execution Performance

*Why is computer architecture relevant to the performance of the execution of a program?*

> CPI (cycles per instruction) is the main variable between computer architectures. Depending on the architecture instruction executions can have 20 states or only 4-5 which is proportional to the number of clock cycles that instruction takes to complete. Depending on the way the bus and memory are structured it could allow for instructions to be fetched and memory to be stored in the same clock cycle. All these factors contribute to an instructions clock cycles on a given architecture. In terms of system *performance*, execution speed considers akk factors that contrinute to perofmance so it can be used to address improvement of those factors for performance gains. Execution time can be measured by `T = (CPI * n) / f` where `n` is the number of instructions and `f` is the CPU clock speed in Hz. From this we can see that the CPI is directly proportionally to execution time `T` therefore proving that program performance is depenedant on the computer architecture it is running on.

*Will all possible software solutions for a problem have the same performance on a given compute?*

> No, software solutions have varying time complexities so the performance can vary independant of the computer architecture. In the execution time performance metric `T = (n * CPI) / f`, varying time-complexity solutions would change `n` the number of instructions.

*Give an example of a common problem that has many algorithms for solutions, and different algorithms can have different time complexity*

> Sorting algorithms have varying time complexities. Insertion and bubble sort have poor time complexities @ O(n<sup>2</sup>) where Radix and counting sort have much better time complexities  @ O(nk) or O(n).

*What does it mean to say that X is N times faster than Y*

> Again, *faster* can refer to system *throughput* or *response time*. However as a general speed metric we use execution time: `T = (IC * CPI) / f`. Then if computer X executes a benchmark program with instruction count `IC` T<sub>x</sub> and computer Y executes the same benchmark T<sub>y</sub> then we can relate the two execution speeds by `N`: `Ty = N * Tx`. If we take the inverse of `T` we can get a performance metric *p<sub>x* and *p<sub>y*: `N * px = py`.

*What is the clock cycle time of a processor with a 100 MHz clock*

> Clock cycle time is just the period *T*: `T = 1/f = 1/1e8 = 1e-8 sec` or 10 nano seconds.

*Does the number of instructions in a program equal the number of cycles needed to execute the program?*

> No, the CPI (cycles per instruction) parameter of the execution time metric defines the number of cycles given an instruction on some computer architecture.

*What is MIPS and how is it different from execution time?*

> MIPS (millions of instructions per second) is a system performance metric which measures *throughput*. Execution time is a system performance metric which measures *response time*. MIPS is related to execution time by : `MIPS = IC / (T * 1e6) = (IC * f) / (IC * CPI * 1e6) = f / (CPI * 1e6)`. We note that MIPS only considers two performance parameters `f` and `CPI` whereas execution time considers `f`, `CPI` and `IC`. This is why execution time is considered to be a better performance indicator.

*If two machines have the same ISA, which aspects of system performance will always be identical?*

> ISA (Instruction Set Architecture) is the set of instructions used by the processor which links the assembly and the underlying hardware. ISA defines:
> - Instruction types supported: ALI
> - Instruction operands: immediated, memory, register operands
> - Registers used
> - Memory organization and addressing
> 
> ISA does not provide information about how the instructions are implemented. For example Intel/AMD support the same ISA (/x86), however they have different hardware architectures. This means that their clock speeds *f* will be different and the cycles per instruction *CPI* will be different. Therefore we can make the following conclusions:
> - Clock speeds are independant of ISA
> - CPI is independant of ISA as the instruction implementation or execution states is a hardware design problem which is outside the scope of ISA
> - Execution times are independant of ISA as a result of the previous two points
> - IC is defined by software design and compiler which is in the scope of the ISA so this will remain constant across like-ISAs. IC is dependant on ISA.
> - MIPS is independant of ISA since it is derived from execution time which is independant of ISA.

*An instruction took on average 1μ to execute on a particular computer. The processor speed was 4 MHz. What was the processor's average CPI?*

>  From the the execution time: `T = (IC * CPI) / f` we can rearrange to `CPI = T * f = 1e-6 s * 4e6 Hz = 4`. Therefore the precise number of cycles for this instruction is 4.

*A program runs in 10 seconds on computer A, which has a 1 GHz clock. We want computer B to run this program in 6 seconds. Assume same ISA in both computers. The trade-off is that for an increase clock rate computer B will suffer 1.2 times as many clock cycles as computer A for the same program. What clock rate will achieve the desired performance?*

> Fist we want to identify our relationships: `Ta = (ICa * CPIa) / fa` and `Ta = (ICa * CPIa) / fa` are our performance relationships for computers A and B respectively. Since the ISA is the same in both computers we know `ICa = ICb`. Furthermore we know `CPIb = 1.2 * CPIa`. So from the performance of computer A we get `ICa * CPIa = 10e9` and from computer B we get `6s * fb = ICb * CPIb`. Using our relationships we can write computer B in terms of A: `6s * fb = ICa * (CPIa / 1.2)` rearranging we get `ICa * CPIa * 1.2 = 6s * fb` we know `ICa * CPIa = 10e9` so `fb = 12e9 / 6s = 2e9` or 2 GHz.

*A processor is running at 500 MHz can execute 50M lines of code in 0.25 seconds. What is the processor's average CPI? What is the MIPS rating of the processor?*

> From execution time the average CPI is given by: `CPI = (T * f) / IC = (0.25s * 5e8Hz) / 50e6 = 2.5`. This is an average because we don't actually know the precise instruction count (we assume the number of instructions for each type of instuction is distributed equally). Given a number of lines of code we can assume an instruction is equivalent to a line of code. The MIPS rating is given by: `MIPS = IC / (T * 1e6) = f / (CPI * 1e6) = 5e8Hz / (2.5 * 1e6) = 200`.