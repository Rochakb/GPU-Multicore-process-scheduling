#include <stdio.h>
#include <cuda.h>
#include <thrust/host_vector.h>
#include "kernel.h"

int schedule(int N, int M, int* arrival_times, int* burst_times, int** cores_schedules, int* cs_lengths){
    int TA = 0;
    
    int arrival[20000], burst[20000], length[10000];             //copy arrival and burst
    for(int j = 0; j < N; j++){
      burst[j] = burst_times[j];
      arrival[j] = arrival_times[j];
    }
    
    for(int i=0; i<M; i++){                                     //malloc 2D array of core schedules
      cores_schedules[i] = (int*) malloc(20000 * sizeof(int*));
    }
   
    for(int i = 0; i < M; i++){                                  //initialization
      cs_lengths[i] = 0;                                         //cs_length zero                            
      length[i] = 0;                                            //cs_length zero  
    }
  
    for(int i=0;i<N;i++){
       
        int len[10000];
        int arr = arrival[i];
        for(int j=0;j<M;j++){
          len[j] = length[j];
          if(length[j]<arr)
            len[j] = 0;
        }
        int *minn = thrust::min_element(thrust::host,len,len+M);
        int min = minn - len;

        if(arrival[i] > length[min])                        //calculate cs_length
          length[min] = arrival[i] + burst[i] - 1;
        else
          length[min] = length[min] + burst[i];
        
        TA = TA + length[min] - arrival[i] + 1;             // calculate TA
        
        cores_schedules[min][cs_lengths[min]] = i;
        cs_lengths[min]++;
    }
    
    
    return TA;
}