
#include"z.h"

#defineBLOCK_DIM_X64

#defineN(x)(erf((x)/sqrt(2.0f))/2+0.5f)

__global__ void gpuBlackScholes(float* call,float* S,float* X,float* T,float* r,float* sigma,int len){

  int ii=threadIdx.x+blockDim.x*blockIdx.x;
  if(ii>len){
    return;
  }
  float d1=
  (log(S[ii]/X[ii])+(r[ii]+(sigma[ii]*sigma[ii])/2)*T[ii])/(sigma[ii]*sqrt(T[ii]));
  float d2=d1-sigma[ii]*sqrt(T[ii]);

  call[ii]=S[ii]*N(d1)-X[ii]*exp(-r[ii]*T[ii])*N(d2);
}

void BlackSholes(zMemory_t out,zMemory_t S,zMemory_t X,zMemory_t T,zMemory_t r,zMemory_t sigma){
  size_t len=zMemory_getFlattenedLength(S);
  dim3 blockDim(BLOCK_DIM_X);
  dim3 gridDim(zCeil(len,blockDim.x));
  zState_t st=zMemory_getState(out);
  cudaStream_t strm=zState_getComputeStream(st,zMemory_getId(out));
  gpuBlackScholes<<<gridDim,blockDim,0,strm>>>
    ((float*)zMemory_getDeviceMemory(out),
    (float*)zMemory_getDeviceMemory(S),
    (float*)zMemory_getDeviceMemory(X),
    (float*)zMemory_getDeviceMemory(T),
    (float*)zMemory_getDeviceMemory(r),
    (float*)zMemory_getDeviceMemory(sigma),
    len);
  return;
}

int main(int argc,char* argv[]){
  size_t dim=atoi(argv[1]);
  zMemoryGroup_t S=zReadFloatArray(st,"S",1,&dim);
  zMemoryGroup_t X=zReadFloatArray(st,"X",1,&dim);
  zMemoryGroup_t T=zReadFloatArray(st,"T",1,&dim);
  zMemoryGroup_t r=zReadFloatArray(st,"r",1,&dim);
  zMemoryGroup_t q=zReadFloatArray(st,"q",1,&dim);
  zMemoryGroup_t out=zMemoryGroup_new(st,zMemoryType_float,1,&dim);
  zMapGroupFunction_t mapFun=zMapGroupFunction_new(st,"blackScholes",BlackSholes);
  zMap(st,mapFun,out,S,X,T,r,q);
  zWriteFloatArray(st,"out",out);
  return 0;
}