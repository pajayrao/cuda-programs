/*
 * Interdependency of Executing Streams
 */

#include<stdio.h>

__global__ void kernel_1()
{
	double sum = 0.0;
	for(int i=0;i<10;i++){
		sum=sum+tan(0.1)*tan(0.1);

	}
}

__global__ void kernel_2()
{
	double sum = 0.0;
	for(int i=0;i<20;i++){
		sum=sum+tan(0.2)*tan(0.2);

	}
}

__global__ void kernel_3()
{
	double sum = 0.0;
	for(int i=0;i<30;i++){
		sum=sum+tan(0.3)*tan(0.3);

	}
}

__global__ void kernel_4()
{
	double sum = 0.0;
	for(int i=0;i<40;i++){
		sum=sum+tan(0.4)*tan(0.4);

	}
}

int main()
{
	int n_streams=5,i,j;
	cudaStream_t *streams = (cudaStream_t*)malloc(n_streams*sizeof(cudaStream_t));
	cudaEvent_t *kernelEvent = (cudaEvent_t*) malloc(n_streams* sizeof(cudaEvent_t));
	for(i=0;i<n_streams;i++)
	{
		cudaEventCreateWithFlags(&kernelEvent[i],cudaEventDisableTiming);

	}
	for(i=0;i<n_streams;i++)
	{
		cudaStreamCreate(&streams[i]);

	}

	dim3 block(1);
	dim3 grid(1);

	for(i=0;i<n_streams;i++)
	{
		kernel_1<<<grid,block,0,streams[i]>>>();
		kernel_2<<<grid,block,0,streams[i]>>>();
		kernel_3<<<grid,block,0,streams[i]>>>();
		kernel_4<<<grid,block,0,streams[i]>>>();
		cudaEventRecord(kernelEvent[i],streams[i]);
		cudaStreamWaitEvent(streams[n_streams-1],kernelEvent[i],0);

	}

	return 0;
}
