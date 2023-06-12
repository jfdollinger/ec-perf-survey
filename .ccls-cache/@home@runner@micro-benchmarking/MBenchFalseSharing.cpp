#include "MBenchFalseSharing.hpp"

MBenchFalseSharing::MBenchFalseSharing(long long int size, int stride,
                                       int num_threads)
    : MBench("false-sharing", size) {
  this->stride = stride;
  this->num_threads = num_threads;
}

void MBenchFalseSharing::alloc() {
  array = new DataType[size * (stride * num_threads)];
}

void MBenchFalseSharing::init() {
  int n = stride * num_threads;

  for (int i = 0; i < size; ++i) {
    for (int j = 0; j < num_threads; ++j) {
      array[i * n + j * stride] = 0;
    }
  }
}

void MBenchFalseSharing::dealloc() { delete[] array; }

MBenchResult *MBenchFalseSharing::run() {
  Time t;
  int i, n = stride * num_threads;

  t.start();
  #pragma omp parallel num_threads(num_threads)
  {
    for (i = 0; i < size; ++i) {
      array[i * n + omp_get_thread_num() * stride] += i;
    }
    #pragma omp barrier
  }
  long long duration = t.stop();

  return new MBenchResult(duration);
}