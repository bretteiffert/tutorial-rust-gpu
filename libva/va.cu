#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

#include <chrono>

#define MAX_ERR 1e-6

// CUDA kernel
__global__ void vector_add(float *out, float *a, float *b, int n) {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    
    // Handling arbitrary vector size
    if (tid < n){
        out[tid] = a[tid] + b[tid];
    }
}

// helper C function called via Rust FFI to faciliate memory transfers and kernel launches
extern "C" void run_vector_add(float * a, float * b, float * out,  int N) { 

    auto start = std::chrono::steady_clock::now();
     	
    float *d_a, *d_b, *d_out;    

    // Allocate device memory
    cudaMalloc((void**)&d_a, sizeof(float) * N);
    cudaMalloc((void**)&d_b, sizeof(float) * N);
    cudaMalloc((void**)&d_out, sizeof(float) * N);
    
    // Transfer data from host to device memory
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);
    
    // Executing kernel 
    int block_size = 256;
    int grid_size = ((N + block_size) / block_size);
    vector_add<<<grid_size,block_size>>>(d_out, d_a, d_b, N);
    
    auto end = std::chrono::steady_clock::now();

    printf("%d ms\n", std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count());

    // Transfer data back to host memory
    cudaMemcpy(out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost);

    // Deallocate device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);

    // Host memory freeing handled by Rust
}
