# Performance

1. Infinite execution time means a program will never complete. Indefinite execution time means the completion time is unknown.
2. Undecidable Problem: in computational theory, an undecidable problem cannot yield an accurate yes/no result by a computer algorithm. The halting problem is an example of such which asks the time at which a program will finish executing. The towers of hanoi problem can be calculated and so its a decidable problem by computational theory.
3. Based on the complexity suggestion of 2<sup>n</sup>-1, the big-O complexity of solving the towers of hanoi for an input of n disks would be O(max(2<sup>n</sup>,-1)) or O(2<sup>n</sup>)
4. The number of operations required for 64 disks would be 2<sup>64</sup>-1 or approximately `1.8446744e19`
5. In order for a computer to achieve `1.8446744e19` operations in the span of a day or `86400` seconds it would have to processing at `1.8446744e19 ins / 86400 sec` or `2.1350398e+14 ins/sec` which is 214 trillion instructions per second. The fastest CPU we have available is an AMD Piledriver based FX-8370 chip which has a clock speed of `8.723 GHz` or the theoretical ability of performing `T = 1 / 8.723e9 = 1.1463946e-10 sec` and `1 ins / 1.1463946e-10 sec = 8722999916.43 ins/sec` which is just the CPU frequency in (Hz). Using performance analysis: `% Increase = 100% * (8722999916.43 ins/sec - 2.1350398e+14 ins/sec) / 8722999916.43 ins/sec = 24474.98 % increase`. So we see that we are not even close to being capable of solving this problem in a day via modern computing.
6. From 5. the clockspeed of the CPU that is capable of completing this problem in a day would have to be `2.135e14 Hz` or `214 THz`.
7. Tractable solution: A problem is said to be tractable if there is an algorithm that, given an input n, can solve the problem in O(n<sup>c</sup>), where c is a constant that depends that problem. However, intractable problems allows exponential complexity versus input increase (O(c<sup>n</sup>)). This problem therefore is intractable since the time complexity of the towers of hanoi is O(2<sup>n</sup>)
7. Algorithms with linear complexity O(n) will result in a linearly scaled increase in problem size `X` in time `t` if the computer processor speed is scaled by a factor of `X`. For example iterating through a list of items is of linear time complexity. For example:
>```c
>sum = 0;
>// initialize n, and x; x is an array of n elements.
>for (i=0; i<n; i=i+1)
>      sum += x[i];
>end
>average = sum/n;
>```
8. CPI (cycles per instruction) is the main variable between computer architectures. Depending on the architecture instruction executions can have 20 states or only 4-5 which is proportional to the number of clock cycles that instruction takes to complete. Depending on the way the bus and memory are structured it could allow for instructions to be fetched and memory to be stored in the same clock cycle. All these factors contribute to an instructions clock cycles on a given architecture. Execution speed can be measured by `T = (CPI * n) / f` where n is the number of instructions and f is the CPU clock speed in Hz. From this we can see that the CPI is directly proportionally to T.