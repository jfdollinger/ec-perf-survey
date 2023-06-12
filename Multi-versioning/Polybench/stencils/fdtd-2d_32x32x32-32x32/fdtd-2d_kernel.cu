#include "fdtd-2d_kernel.hu"
__global__ void kernel0(double *ey, double *hz, int ny, int tmax, int nx, int c0)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;

    for (int c1 = 32 * b0; c1 < nx - 1; c1 += 8192)
      if (nx >= t0 + c1 + 2)
        for (int c2 = 32 * b1; c2 < ny; c2 += 8192)
          if (ny >= t1 + c2 + 1)
            ey[(t0 + c1 + 1) * ny + (t1 + c2)] = (ey[(t0 + c1 + 1) * ny + (t1 + c2)] - (0.5 * (hz[(t0 + c1 + 1) * ny + (t1 + c2)] - hz[(t0 + c1) * ny + (t1 + c2)])));
}
__global__ void kernel1(double *ex, double *hz, int ny, int tmax, int nx, int c0)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;

    for (int c1 = 32 * b0; c1 < nx; c1 += 8192)
      if (nx >= t0 + c1 + 1)
        for (int c2 = 32 * b1; c2 < ny - 1; c2 += 8192)
          if (ny >= t1 + c2 + 2)
            ex[(t0 + c1) * ny + (t1 + c2 + 1)] = (ex[(t0 + c1) * ny + (t1 + c2 + 1)] - (0.5 * (hz[(t0 + c1) * ny + (t1 + c2 + 1)] - hz[(t0 + c1) * ny + (t1 + c2)])));
}
__global__ void kernel2(double *_fict_, double *ex, double *ey, double *hz, int ny, int tmax, int nx, int c0)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    __shared__ double shared__fict_[1];

    {
      if (t0 == 0 && t1 == 0)
        shared__fict_[0] = _fict_[c0];
      __syncthreads();
      if (ny >= 32 * b1 + 2)
        for (int c1 = 32 * b0; c1 < nx - 1; c1 += 8192)
          if (nx >= t0 + c1 + 2) {
            for (int c2 = 32 * b1; c2 < ny - 1; c2 += 8192) {
              if (b0 == 0 && t0 == 0 && c1 == 0 && ny >= t1 + c2 + 1)
                ey[0 * ny + (t1 + c2)] = shared__fict_[0];
              if (ny >= t1 + c2 + 2)
                hz[(t0 + c1) * ny + (t1 + c2)] = (hz[(t0 + c1) * ny + (t1 + c2)] - (0.69999999999999996 * (((ex[(t0 + c1) * ny + (t1 + c2 + 1)] - ex[(t0 + c1) * ny + (t1 + c2)]) + ey[(t0 + c1 + 1) * ny + (t1 + c2)]) - ey[(t0 + c1) * ny + (t1 + c2)])));
            }
            if (b0 == 0 && t0 == 0 && t1 == 0 && c1 == 0 && (-ny + 32 * b1 + 1) % 8192 == 0)
              ey[0 * ny + (ny - 1)] = shared__fict_[0];
          }
      if (nx <= 1 && b0 == 0 && t0 == 0) {
        for (int c2 = 32 * b1; c2 < ny; c2 += 8192)
          if (ny >= t1 + c2 + 1)
            ey[0 * ny + (t1 + c2)] = shared__fict_[0];
      } else if (nx >= 2 && b0 == 0 && 32 * b1 + 1 == ny && t0 == 0 && t1 == 0) {
        ey[0 * ny + (ny - 1)] = shared__fict_[0];
      }
    }
}
