#include "gemm_kernel.hu"
__global__ void kernel0(double *A, double *B, double *C, double alpha, double beta, int nj, int nk, int ni)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    double private_C[4][4];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    for (int c0 = 128 * b0; c0 < ni; c0 += 32768)
      for (int c1 = 128 * b1; c1 < nj; c1 += 32768) {
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          private_C[0][0] = C[(t0 + c0) * nj + (t1 + c1)];
          if (nj >= t1 + c1 + 33) {
            private_C[0][1] = C[(t0 + c0) * nj + (t1 + c1 + 32)];
            if (nj >= t1 + c1 + 65) {
              private_C[0][2] = C[(t0 + c0) * nj + (t1 + c1 + 64)];
              if (nj >= t1 + c1 + 97)
                private_C[0][3] = C[(t0 + c0) * nj + (t1 + c1 + 96)];
            }
          }
          if (ni >= t0 + c0 + 33) {
            private_C[1][0] = C[(t0 + c0 + 32) * nj + (t1 + c1)];
            if (nj >= t1 + c1 + 33) {
              private_C[1][1] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 32)];
              if (nj >= t1 + c1 + 65) {
                private_C[1][2] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 64)];
                if (nj >= t1 + c1 + 97)
                  private_C[1][3] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 96)];
              }
            }
            if (ni >= t0 + c0 + 65) {
              private_C[2][0] = C[(t0 + c0 + 64) * nj + (t1 + c1)];
              if (nj >= t1 + c1 + 33) {
                private_C[2][1] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 32)];
                if (nj >= t1 + c1 + 65) {
                  private_C[2][2] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 64)];
                  if (nj >= t1 + c1 + 97)
                    private_C[2][3] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 96)];
                }
              }
              if (ni >= t0 + c0 + 97) {
                private_C[3][0] = C[(t0 + c0 + 96) * nj + (t1 + c1)];
                if (nj >= t1 + c1 + 33) {
                  private_C[3][1] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 32)];
                  if (nj >= t1 + c1 + 65) {
                    private_C[3][2] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 64)];
                    if (nj >= t1 + c1 + 97)
                      private_C[3][3] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 96)];
                  }
                }
              }
            }
          }
          private_C[0][0] *= beta;
          if (nj >= t1 + c1 + 33) {
            private_C[0][1] *= beta;
            if (nj >= t1 + c1 + 65) {
              private_C[0][2] *= beta;
              if (nj >= t1 + c1 + 97)
                private_C[0][3] *= beta;
            }
          }
          if (ni >= t0 + c0 + 33) {
            private_C[1][0] *= beta;
            if (nj >= t1 + c1 + 33) {
              private_C[1][1] *= beta;
              if (nj >= t1 + c1 + 65) {
                private_C[1][2] *= beta;
                if (nj >= t1 + c1 + 97)
                  private_C[1][3] *= beta;
              }
            }
            if (ni >= t0 + c0 + 65) {
              private_C[2][0] *= beta;
              if (nj >= t1 + c1 + 33) {
                private_C[2][1] *= beta;
                if (nj >= t1 + c1 + 65) {
                  private_C[2][2] *= beta;
                  if (nj >= t1 + c1 + 97)
                    private_C[2][3] *= beta;
                }
              }
              if (ni >= t0 + c0 + 97) {
                private_C[3][0] *= beta;
                if (nj >= t1 + c1 + 33) {
                  private_C[3][1] *= beta;
                  if (nj >= t1 + c1 + 65) {
                    private_C[3][2] *= beta;
                    if (nj >= t1 + c1 + 97)
                      private_C[3][3] *= beta;
                  }
                }
              }
            }
          }
          for (int c2 = 0; c2 < nk; c2 += 128)
            for (int c3 = 0; c3 <= ppcg_min(127, nk - c2 - 1); c3 += 1) {
              private_C[0][0] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
              if (nj >= t1 + c1 + 33) {
                private_C[0][1] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                if (nj >= t1 + c1 + 65) {
                  private_C[0][2] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                  if (nj >= t1 + c1 + 97)
                    private_C[0][3] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                }
              }
              if (ni >= t0 + c0 + 33) {
                private_C[1][0] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                if (nj >= t1 + c1 + 33) {
                  private_C[1][1] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                  if (nj >= t1 + c1 + 65) {
                    private_C[1][2] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                    if (nj >= t1 + c1 + 97)
                      private_C[1][3] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                  }
                }
                if (ni >= t0 + c0 + 65) {
                  private_C[2][0] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                  if (nj >= t1 + c1 + 33) {
                    private_C[2][1] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                    if (nj >= t1 + c1 + 65) {
                      private_C[2][2] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                      if (nj >= t1 + c1 + 97)
                        private_C[2][3] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                    }
                  }
                  if (ni >= t0 + c0 + 97) {
                    private_C[3][0] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                    if (nj >= t1 + c1 + 33) {
                      private_C[3][1] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                      if (nj >= t1 + c1 + 65) {
                        private_C[3][2] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                        if (nj >= t1 + c1 + 97)
                          private_C[3][3] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                      }
                    }
                  }
                }
              }
            }
          C[(t0 + c0) * nj + (t1 + c1)] = private_C[0][0];
          if (nj >= t1 + c1 + 33) {
            C[(t0 + c0) * nj + (t1 + c1 + 32)] = private_C[0][1];
            if (nj >= t1 + c1 + 65) {
              C[(t0 + c0) * nj + (t1 + c1 + 64)] = private_C[0][2];
              if (nj >= t1 + c1 + 97)
                C[(t0 + c0) * nj + (t1 + c1 + 96)] = private_C[0][3];
            }
          }
          if (ni >= t0 + c0 + 33) {
            C[(t0 + c0 + 32) * nj + (t1 + c1)] = private_C[1][0];
            if (nj >= t1 + c1 + 33) {
              C[(t0 + c0 + 32) * nj + (t1 + c1 + 32)] = private_C[1][1];
              if (nj >= t1 + c1 + 65) {
                C[(t0 + c0 + 32) * nj + (t1 + c1 + 64)] = private_C[1][2];
                if (nj >= t1 + c1 + 97)
                  C[(t0 + c0 + 32) * nj + (t1 + c1 + 96)] = private_C[1][3];
              }
            }
            if (ni >= t0 + c0 + 65) {
              C[(t0 + c0 + 64) * nj + (t1 + c1)] = private_C[2][0];
              if (nj >= t1 + c1 + 33) {
                C[(t0 + c0 + 64) * nj + (t1 + c1 + 32)] = private_C[2][1];
                if (nj >= t1 + c1 + 65) {
                  C[(t0 + c0 + 64) * nj + (t1 + c1 + 64)] = private_C[2][2];
                  if (nj >= t1 + c1 + 97)
                    C[(t0 + c0 + 64) * nj + (t1 + c1 + 96)] = private_C[2][3];
                }
              }
              if (ni >= t0 + c0 + 97) {
                C[(t0 + c0 + 96) * nj + (t1 + c1)] = private_C[3][0];
                if (nj >= t1 + c1 + 33) {
                  C[(t0 + c0 + 96) * nj + (t1 + c1 + 32)] = private_C[3][1];
                  if (nj >= t1 + c1 + 65) {
                    C[(t0 + c0 + 96) * nj + (t1 + c1 + 64)] = private_C[3][2];
                    if (nj >= t1 + c1 + 97)
                      C[(t0 + c0 + 96) * nj + (t1 + c1 + 96)] = private_C[3][3];
                  }
                }
              }
            }
          }
        }
        __syncthreads();
      }
}
