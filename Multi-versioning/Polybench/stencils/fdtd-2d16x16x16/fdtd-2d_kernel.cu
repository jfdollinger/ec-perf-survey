#include "fdtd-2d_kernel.hu"
__global__ void kernel0(double *ey, double *hz, int ny, int tmax, int nx, int c0)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;

    for (int c1 = 16 * b0; c1 < nx - 1; c1 += 4096)
      if (nx >= t0 + c1 + 2)
        for (int c2 = 16 * b1; c2 < ny; c2 += 4096)
          if (ny >= t1 + c2 + 1)
            ey[(t0 + c1 + 1) * ny + (t1 + c2)] = (ey[(t0 + c1 + 1) * ny + (t1 + c2)] - (0.5 * (hz[(t0 + c1 + 1) * ny + (t1 + c2)] - hz[(t0 + c1) * ny + (t1 + c2)])));
}
__global__ void kernel1(double *ex, double *hz, int ny, int tmax, int nx, int c0)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;

    for (int c1 = 16 * b0; c1 < nx; c1 += 4096)
      if (nx >= t0 + c1 + 1)
        for (int c2 = 16 * b1; c2 < ny - 1; c2 += 4096)
          if (ny >= t1 + c2 + 2)
            ex[(t0 + c1) * ny + (t1 + c2 + 1)] = (ex[(t0 + c1) * ny + (t1 + c2 + 1)] - (0.5 * (hz[(t0 + c1) * ny + (t1 + c2 + 1)] - hz[(t0 + c1) * ny + (t1 + c2)])));
}
__global__ void kernel2(double *_fict_, double *ex, double *ey, double *hz, int ny, int tmax, int nx, int c0)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    __shared__ double shared__fict_[1];
    __shared__ double shared_ey[17][16];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    {
      if (t0 == 0 && t1 == 0)
        shared__fict_[0] = _fict_[c0];
      __syncthreads();
      if (ny >= 16 * b1 + 2)
        for (int c1 = 16 * b0; c1 < nx - 1; c1 += 4096) {
          for (int c2 = 16 * b1; c2 < ny - 1; c2 += 4096) {
            if (ny >= t1 + c2 + 1)
              for (int c3 = t0; c3 <= ppcg_min(16, nx - c1 - 1); c3 += 16)
                shared_ey[c3][t1] = ey[(c1 + c3) * ny + (t1 + c2)];
            __syncthreads();
            if (b0 == 0 && t0 == 0 && c1 == 0 && ny >= t1 + c2 + 1)
              shared_ey[0][t1] = shared__fict_[0];
            if (nx >= t0 + c1 + 2 && ny >= t1 + c2 + 2)
              hz[(t0 + c1) * ny + (t1 + c2)] = (hz[(t0 + c1) * ny + (t1 + c2)] - (0.69999999999999996 * (((ex[(t0 + c1) * ny + (t1 + c2 + 1)] - ex[(t0 + c1) * ny + (t1 + c2)]) + shared_ey[t0 + 1][t1]) - shared_ey[t0][t1])));
            __syncthreads();
            if (b0 == 0 && t0 == 0 && c0 + 1 == tmax && c1 == 0 && ny >= t1 + c2 + 1)
              ey[0 * ny + (t1 + c2)] = shared_ey[0][t1];
          }
          if (b0 == 0 && c1 == 0 && (-ny + 16 * b1 + 1) % 4096 == 0) {
            if (t1 == 0)
              for (int c3 = t0; c3 <= ppcg_min(16, nx - 1); c3 += 16)
                shared_ey[c3][0] = ey[c3 * ny + (ny - 1)];
            __syncthreads();
            if (t0 == 0 && t1 == 0)
              shared_ey[0][0] = shared__fict_[0];
            __syncthreads();
            if (t0 == 0 && t1 == 0 && c0 + 1 == tmax)
              ey[0 * ny + (ny - 1)] = shared_ey[0][0];
          }
        }
      if (nx <= 1 && b0 == 0) {
        for (int c2 = 16 * b1; c2 < ny; c2 += 4096) {
          if (t0 == 0 && ny >= t1 + c2 + 1)
            shared_ey[0][t1] = ey[0 * ny + (t1 + c2)];
          __syncthreads();
          if (t0 == 0 && ny >= t1 + c2 + 1)
            shared_ey[0][t1] = shared__fict_[0];
          __syncthreads();
          if (t0 == 0 && c0 + 1 == tmax && ny >= t1 + c2 + 1)
            ey[0 * ny + (t1 + c2)] = shared_ey[0][t1];
        }
      } else if (nx >= 2 && b0 == 0 && 16 * b1 + 1 == ny) {
        if (t1 == 0)
          for (int c3 = t0; c3 <= ppcg_min(16, nx - 1); c3 += 16)
            shared_ey[c3][0] = ey[c3 * ny + (ny - 1)];
        __syncthreads();
        if (t0 == 0 && t1 == 0)
          shared_ey[0][0] = shared__fict_[0];
        __syncthreads();
        if (t0 == 0 && t1 == 0 && c0 + 1 == tmax)
          ey[0 * ny + (ny - 1)] = shared_ey[0][0];
      }
    }
}
