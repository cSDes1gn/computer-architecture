# Cache Architecture

**Cache Thrashing** is a repetitive computer activity where blocks of instructions are loaded into the cache line, then immediately, data from another address which conflicts with instructions overwrites the instructions. The next instruction then overwrites the data with its instructions and the cycle ensues. The thrashing continues as long as instruction addresses and data addresses map to the same cache location.

As we can see cache can hold instructions and data.

Success pf block-based hierarchy depends on the locality behaviour of application programs

## High-Level Cache Operation
1. Program performs memeory access
2. Cache memory is searched first and if the addressed word is present then its a **cache hit** and the contents of the addressed word is returned to the CPU.
3. If the word is not in cache then it is a **cache miss**. Main memory has to be accessed for the address and a copy of the memory *block* is put into the cache for later reference.

### Cache Organization

Cache is organizzed into two sections:
1. Cached management data contains the cached addresses for each cached block
2. Cached Blocks is made up of lines containing blocks from main memory

### Cache Placement Strategy
Determining cache hit or miss will depend on the implemented placememnt strategy:
- Associative
- Direct-Mapped
- Set-associative

> #### Associative Mapping
> A memory block from main memory can be stored in any line of cache. Cache management data contains the following fields:
> 1. Tag bits (identify the block)
> 2. Word bits (identify the word in the block)
> 
> Cache hit/miss is determined by identifying the tag bits in the CPU requested address and comparing that tag to tags stored in cache. If the tag is not found in cache it is a cache miss otherwise it is a cache hit. 
> > This is very inefficient as the CPU has to iterate over the whole cache before it can make a hit/miss conclusion.

> #### Direct Mapping
> A memory block from main memory can only be stored in one line of cache. Cache management data contains the following fields:
> 1. Tag bits (identify the block)
> 2. Line bits (identifies the cache line for the address). Each cache line has a cache address *[0,lines-1]*
> 3. Word bits (identify the word in the block)
> 
> The line field is an excellent addition due to its increased cache search optimization. It provides a much shorter critical path to determining a cache hit or miss. We will see however we cannot implement a smart cache with a replacement policy since there is no choice in which lines to release and allocate.
> > Instead of analyzing the tag bits of a requested address and searches all cahce blocks for an identical tag, direct mapping identifies a *line* identifier from the address which maps to a specific line in cache. Then once the line is found it compares the requested address tag to the tag of the block stored in that specific line. Cache hit/miss is determined by matching tag bits. It is clear that this approach is much faster as no cache iteration is required.

> #### K-Way Set-Associative Cache Mapping
> This cache map reorganizes lines into sets of *k* lines. Each set treated as an associative cache system using the tag bits to ideentify the block within a set. A block can be read into any cache line as long as it resides in its appropriate *set*. Each memory address is divided into 3 fields:
> 1. Tag bits (identify the block)
> 2. Set bits (identifies the set that holds the relevant block). Each cache line has a cache address *[0,(lines/k)-1]*
> 3. Word bits (identify the word in the block)
>
> Set bits are direct mapped to a set. All lines with **V** = 1 are examined in parallel. If a cache line is found with cached tag equal to address tag then its a cache hit. For a miss, the block from main memory is loaded into a line in selected set. for the line set **V** = 1, cached tag = address tag and cached block = block from memory.
>
> > This mapping solves the iterative problem with associative mapping by dividing the cache into *sets* which are treated as associative mapped cache. This drastically reduces the size of the iterator making the critical path to determining a cache hit or miss similar in performance to direct mapping. The *set* is selected by direct map (treated like the *line* field in direct mapping) in identifying a subset of lines to check for the block with the correct *tag* identifier.

### Cache Read/Write Policy

For **Write Through** architecture, when a write command is issued the write is done to the location in cache and its address in main memory to ensure both are synchronized. If the cache uses a **Write Back** architecture, the data is written to that cache location and the **D** bit is set to 1 for that line indicating that the memory stored here is dirty (needs to update main memory with its newly written contents). When a block with a **D** = 1 is replaced in cache its contents are written to main memory. 

If a cache read command is a cache miss we can use a **Load-Through** architecture which forwards the requested word to the CPU as the cache line is updated or fill the cache line first then forward the word.

### Cache Replacement Policy

Only relevant for architectures that use associative mapping since for direct mapping there is no choice which lines to use.

>**LRU**: Least Recently Used overerites the line that has been the last to be used when all other lines have been used at least once.

>**LFU**: Least Frequently Used keeps a running count of line uses and replaces the line with the fewest uses.

>**Random**: Unintelligent cache policy that saves memory (no running count of line analytics) and is easier to implement. Bad idea to implement if instructions and data are stored in cache because it may cause instructions that are used frequently to be replaced by data used infrequently.

## Addressing Basics

**Addressable Words** refers to the quantity of data grabbed in an addressing operation. If a system is organized as 16-bit addressable words then the address space would be organized in increments of 2B. So addressing operations will be functioning by reading/writing 2B worth of address space.