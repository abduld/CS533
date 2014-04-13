% CS533: HW3
% Abdul Dakkak

## Question 1: TLS


a. TLS 

b. TLS 


## Question 2 : Speculative Synchronization

a.

b. 

c.

## Question 3 : Processor in Memory

a. PIM brings computation close to the memory system and therefor can give you high compute throughput. It allows you to not fetch data from memory iff the PIM has the capability to execute the instruction. The main disadvantage is in terms of manifacturing. Memory is manifactured to increase space density, while processors are manifactured to increase compute speed. There is also the basic question of how useful are PIMs in the first place, usual programs have the processor usually fetching memory and execute hundreds or thousands of instructions on the memory fetched, this means that the memory copy overhead is not as high as the compute overhead.

b. The type of applications that benifit from PIM are ones that do basic operations or permutations on the memory elements (transpose, shuffle, etc...). High compute work loads, such as scientific workloads, would not work on PIM (unless you add support for those instructions --- which results in you just having a second processor that's closer to memory).

c. 
TODO

    1) for (i = 0; i < 1000; i++) 
         A[i] = B[i]; 

There is a cache miss every 8 iterations.


    2) for (i = 0; i < 1000; i++) 
         A[i] = B[i] * B[i + 1]; 

There is a cache miss every 7 iterations.


    3) for (i = 0; i < 1000; i += 4) 
         A[i] = B[i]; 


There is a cache miss every 2 iterations.


## Question 3 : Reliability


