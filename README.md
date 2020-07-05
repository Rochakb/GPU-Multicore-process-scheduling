# GPU-Multicore-process-scheduling
Used the multi-queue scheduling algorithm with load balancing, a multiprocessor variant of the First Come First Serve (FCFS) schedulingalgorithm. There is NO pre-emption.

Input

•N: Number of processes
•M: Number of cores
•arrival_times: An array containing N arrival times
•burst_times: An array containing N execution/burst times
            
            8 4
            1 4
            1 5
            2 3
            2 4
            2 6
            3 4
            3 8
            7 3
            
Constraints

• 1 ≤ N ≤ 20000
• 1 ≤ M ≤ 10000
• 1 ≤ all arrival time values and execution time values ≤ 1000
• No more than 2000 processes will have the same arrival time

Output: Minimum turnaround time.
