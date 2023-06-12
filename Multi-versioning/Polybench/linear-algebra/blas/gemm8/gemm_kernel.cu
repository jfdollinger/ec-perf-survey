#include "gemm_kernel.hu"
__global__ void kernel0(double *A, double *B, double *C, double alpha, double beta, int nj, int nk, int ni)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    __shared__ double shared_A[8][8];
    __shared__ double shared_B[8][8];
    double private_C[1][1];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    for (int c0 = 8 * b0; c0 < ni; c0 += 2048)
      for (int c1 = 8 * b1; c1 < nj; c1 += 2048) {
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1)
          private_C[0][0] = C[(t0 + c0) * nj + (t1 + c1)];
        for (int c2 = 0; c2 < nk; c2 += 8) {
          if (ni >= t0 + c0 + 1 && nk >= t1 + c2 + 1)
            shared_A[t0][t1] = A[(t0 + c0) * nk + (t1 + c2)];
          if (nj >= t1 + c1 + 1 && nk >= t0 + c2 + 1)
            shared_B[t0][t1] = B[(t0 + c2) * nj + (t1 + c1)];
          __syncthreads();
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1 && c2 == 0)
            private_C[0][0] *= beta;
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1)
            for (int c5 = 0; c5 <= ppcg_min(7, nk - c2 - 1); c5 += 1)
              private_C[0][0] += ((alpha * shared_A[t0][c5]) * shared_B[c5][t1]);
          __syncthreads();
        }
        if (nk == 0) {
          __syncthreads();
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1)
            private_C[0][0] *= beta;
          __syncthreads();
        }
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1)
          C[(t0 + c0) * nj + (t1 + c1)] = private_C[0][0];
        __syncthreads();
      }
}
