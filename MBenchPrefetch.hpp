#pragma once

#include <iostream>
#include <cstdlib>
#include "omp.h"
#include "MBench.hpp"

class MBenchPrefetch : public MBench {
  typedef long long int DataType;
protected:
  long long int size;
  string name;

  DataType *array;
public:
  static const int NEXP = 100;
public:
  MBenchPrefetch(long long int size);

  virtual void prepare(int *indir) = 0;

  void alloc();
  void init();
  MBenchResult *run();
  void dealloc();

  ~MBenchPrefetch();
};

class MBenchPrefetchSequential  : public MBenchPrefetch {
public:
  MBenchPrefetchSequential(long long int size) : MBenchPrefetch(size) { name = "prefetch-sequential"; }

  void prepare(int *indir);
};

class MBenchPrefetchRandom  : public MBenchPrefetch {
public:
  const int STRIDE = 5;
public:
  MBenchPrefetchRandom(long long int size) : MBenchPrefetch(size) { name = "prefetch-random"; }

  void prepare(int *indir);
};