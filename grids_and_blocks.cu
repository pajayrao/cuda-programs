/*
 * Check grid and block dimensions
 */

#include<stdio.h>

__global__ void checkIndex(void)
{
	printf("threadIdx : (%d,%d,%d) blockIdx : (%d,%d,%d)) blockDim : (%d,%d,%d) gridDim : (%d,%d,%d)\n ",threadIdx.x,threadIdx.y,threadIdx.z,blockIdx.x,blockIdx.y,blockIdx.z,blockDim.x,blockDim.y,blockDim.z,gridDim.x,gridDim.y,gridDim.z);
}

int main(void)
{	int n=6;
	dim3 block(3);
	dim3 grid((n+block.x-1)/block.x);

	checkIndex<<<grid,block>>>();
	cudaDeviceReset();

}
