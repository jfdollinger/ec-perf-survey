#include "gemm_kernel.hu"
__global__ void kernel0(double *A, double *B, double *C, double alpha, double beta, int nj, int nk, int ni)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    __shared__ double shared_A[32][32];
    double private_C[2][2];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    for (int c0 = 32 * b0; c0 < ni; c0 += 8192)
      for (int c1 = 32 * b1; c1 < nj; c1 += 8192) {
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          private_C[0][0] = C[(t0 + c0) * nj + (t1 + c1)];
          if (nj >= t1 + c1 + 17)
            private_C[0][1] = C[(t0 + c0) * nj + (t1 + c1 + 16)];
          if (ni >= t0 + c0 + 17) {
            private_C[1][0] = C[(t0 + c0 + 16) * nj + (t1 + c1)];
            if (nj >= t1 + c1 + 17)
              private_C[1][1] = C[(t0 + c0 + 16) * nj + (t1 + c1 + 16)];
          }
        }
        for (int c2 = 0; c2 < nk; c2 += 32) {
          for (int c3 = t0; c3 <= ppcg_min(31, ni - c0 - 1); c3 += 16)
            for (int c4 = t1; c4 <= ppcg_min(31, nk - c2 - 1); c4 += 16)
              shared_A[c3][c4] = A[(c0 + c3) * nk + (c2 + c4)];
          __syncthreads();
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1 && c2 == 0) {
            private_C[0][0] *= beta;
            if (nj >= t1 + c1 + 17)
              private_C[0][1] *= beta;
            if (ni >= t0 + c0 + 17) {
              private_C[1][0] *= beta;
              if (nj >= t1 + c1 + 17)
                private_C[1][1] *= beta;
            }
          }
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1)
            for (int c3 = 0; c3 <= ppcg_min(31, nk - c2 - 1); c3 += 1) {
              private_C[0][0] += ((alpha * shared_A[t0][c3]) * B[(c2 + c3) * nj + (t1 + c1)]);
              if (nj >= t1 + c1 + 17)
                private_C[0][1] += ((alpha * shared_A[t0][c3]) * B[(c2 + c3) * nj + (t1 + c1 + 16)]);
              if (ni >= t0 + c0 + 17) {
                private_C[1][0] += ((alpha * shared_A[t0 + 16][c3]) * B[(c2 + c3) * nj + (t1 + c1)]);
                if (nj >= t1 + c1 + 17)
                  private_C[1][1] += ((alpha * shared_A[t0 + 16][c3]) * B[(c2 + c3) * nj + (t1 + c1 + 16)]);
              }
            }
          __syncthreads();
        }
        if (nk == 0) {
          __syncthreads();
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
            private_C[0][0] *= beta;
            if (nj >= t1 + c1 + 17)
              private_C[0][1] *= beta;
            if (ni >= t0 + c0 + 17) {
              private_C[1][0] *= beta;
              if (nj >= t1 + c1 + 17)
                private_C[1][1] *= beta;
            }
          }
          __syncthreads();
        }
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          C[(t0 + c0) * nj + (t1 + c1)] = private_C[0][0];
          if (nj >= t1 + c1 + 17)
            C[(t0 + c0) * nj + (t1 + c1 + 16)] = private_C[0][1];
          if (ni >= t0 + c0 + 17) {
            C[(t0 + c0 + 16) * nj + (t1 + c1)] = private_C[1][0];
            if (nj >= t1 + c1 + 17)
              C[(t0 + c0 + 16) * nj + (t1 + c1 + 16)] = private_C[1][1];
          }
        }
        __syncthreads();
      }
}
