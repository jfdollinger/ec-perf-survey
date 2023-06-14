#include "gemm_kernel.hu"
__global__ void kernel0(double *A, double *B, double *C, double alpha, double beta, int nj, int nk, int ni)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    double private_C[1][1];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    for (int c0 = 32 * b0; c0 < ni; c0 += 8192)
      for (int c1 = 32 * b1; c1 < nj; c1 += 8192) {
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          private_C[0][0] = C[(t0 + c0) * nj + (t1 + c1)];
          private_C[0][0] *= beta;
          for (int c2 = 0; c2 < nk; c2 += 64)
            for (int c5 = 0; c5 <= ppcg_min(63, nk - c2 - 1); c5 += 1)
              private_C[0][0] += ((alpha * A[(t0 + c0) * nk + (c2 + c5)]) * B[(c2 + c5) * nj + (t1 + c1)]);
          C[(t0 + c0) * nj + (t1 + c1)] = private_C[0][0];
        }
        __syncthreads();
      }
}
