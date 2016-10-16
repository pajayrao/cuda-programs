/*
 * Hello World Program from GPU
 */


#include<stdio.h>

__global__ void helloWorldFromGPU(void)
{	int x= threadIdx.x;
	printf("Hello World from GPU! thread id  %d\n",x);

}

int main(void)
{
	printf("Hello World from CPU!");
	helloWorldFromGPU<<<1,10>>>();
	cudaDeviceSynchronize();
	return 0;

}
