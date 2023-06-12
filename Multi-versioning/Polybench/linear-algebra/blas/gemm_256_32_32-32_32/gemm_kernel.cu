#include "gemm_kernel.hu"
__global__ void kernel0(double *A, double *B, double *C, double alpha, double beta, int nj, int nk, int ni)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    __shared__ double shared_B[32][32];
    double private_C[8][1];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    for (int c0 = 256 * b0; c0 < ni; c0 += 65536)
      for (int c1 = 32 * b1; c1 < nj; c1 += 8192) {
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          private_C[0][0] = C[(t0 + c0) * nj + (t1 + c1)];
          if (ni >= t0 + c0 + 33) {
            private_C[1][0] = C[(t0 + c0 + 32) * nj + (t1 + c1)];
            if (ni >= t0 + c0 + 65) {
              private_C[2][0] = C[(t0 + c0 + 64) * nj + (t1 + c1)];
              if (ni >= t0 + c0 + 97) {
                private_C[3][0] = C[(t0 + c0 + 96) * nj + (t1 + c1)];
                if (ni >= t0 + c0 + 129) {
                  private_C[4][0] = C[(t0 + c0 + 128) * nj + (t1 + c1)];
                  if (ni >= t0 + c0 + 161) {
                    private_C[5][0] = C[(t0 + c0 + 160) * nj + (t1 + c1)];
                    if (ni >= t0 + c0 + 193) {
                      private_C[6][0] = C[(t0 + c0 + 192) * nj + (t1 + c1)];
                      if (ni >= t0 + c0 + 225)
                        private_C[7][0] = C[(t0 + c0 + 224) * nj + (t1 + c1)];
                    }
                  }
                }
              }
            }
          }
        }
        for (int c2 = 0; c2 < nk; c2 += 32) {
          if (nj >= t1 + c1 + 1 && nk >= t0 + c2 + 1)
            shared_B[t0][t1] = B[(t0 + c2) * nj + (t1 + c1)];
          __syncthreads();
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1 && c2 == 0) {
            private_C[0][0] *= beta;
            if (ni >= t0 + c0 + 33) {
              private_C[1][0] *= beta;
              if (ni >= t0 + c0 + 65) {
                private_C[2][0] *= beta;
                if (ni >= t0 + c0 + 97) {
                  private_C[3][0] *= beta;
                  if (ni >= t0 + c0 + 129) {
                    private_C[4][0] *= beta;
                    if (ni >= t0 + c0 + 161) {
                      private_C[5][0] *= beta;
                      if (ni >= t0 + c0 + 193) {
                        private_C[6][0] *= beta;
                        if (ni >= t0 + c0 + 225)
                          private_C[7][0] *= beta;
                      }
                    }
                  }
                }
              }
            }
          }
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1)
            for (int c3 = 0; c3 <= ppcg_min(31, nk - c2 - 1); c3 += 1) {
              private_C[0][0] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * shared_B[c3][t1]);
              if (ni >= t0 + c0 + 33) {
                private_C[1][0] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                if (ni >= t0 + c0 + 65) {
                  private_C[2][0] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                  if (ni >= t0 + c0 + 97) {
                    private_C[3][0] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                    if (ni >= t0 + c0 + 129) {
                      private_C[4][0] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                      if (ni >= t0 + c0 + 161) {
                        private_C[5][0] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                        if (ni >= t0 + c0 + 193) {
                          private_C[6][0] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                          if (ni >= t0 + c0 + 225)
                            private_C[7][0] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * shared_B[c3][t1]);
                        }
                      }
                    }
                  }
                }
              }
            }
          __syncthreads();
        }
        if (nk == 0) {
          __syncthreads();
          if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
            private_C[0][0] *= beta;
            if (ni >= t0 + c0 + 33) {
              private_C[1][0] *= beta;
              if (ni >= t0 + c0 + 65) {
                private_C[2][0] *= beta;
                if (ni >= t0 + c0 + 97) {
                  private_C[3][0] *= beta;
                  if (ni >= t0 + c0 + 129) {
                    private_C[4][0] *= beta;
                    if (ni >= t0 + c0 + 161) {
                      private_C[5][0] *= beta;
                      if (ni >= t0 + c0 + 193) {
                        private_C[6][0] *= beta;
                        if (ni >= t0 + c0 + 225)
                          private_C[7][0] *= beta;
                      }
                    }
                  }
                }
              }
            }
          }
          __syncthreads();
        }
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          C[(t0 + c0) * nj + (t1 + c1)] = private_C[0][0];
          if (ni >= t0 + c0 + 33) {
            C[(t0 + c0 + 32) * nj + (t1 + c1)] = private_C[1][0];
            if (ni >= t0 + c0 + 65) {
              C[(t0 + c0 + 64) * nj + (t1 + c1)] = private_C[2][0];
              if (ni >= t0 + c0 + 97) {
                C[(t0 + c0 + 96) * nj + (t1 + c1)] = private_C[3][0];
                if (ni >= t0 + c0 + 129) {
                  C[(t0 + c0 + 128) * nj + (t1 + c1)] = private_C[4][0];
                  if (ni >= t0 + c0 + 161) {
                    C[(t0 + c0 + 160) * nj + (t1 + c1)] = private_C[5][0];
                    if (ni >= t0 + c0 + 193) {
                      C[(t0 + c0 + 192) * nj + (t1 + c1)] = private_C[6][0];
                      if (ni >= t0 + c0 + 225)
                        C[(t0 + c0 + 224) * nj + (t1 + c1)] = private_C[7][0];
                    }
                  }
                }
              }
            }
          }
        }
        __syncthreads();
      }
}
