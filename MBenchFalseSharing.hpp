#pragma once
#include <iostream>
#include <cstdlib>
#include "omp.h"
#include "MBench.hpp"

class MBenchFalseSharing : public MBench {
public:
typedef long long int DataType;
protected:
  int stride;
  int num_threads;

  DataType *array;
public:
  MBenchFalseSharing(long long int size, int stride, int num_threads);

  void alloc();
  void init();
  MBenchResult *run();
  void dealloc();
};
