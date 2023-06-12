#pragma once

#include "MBench.hpp"

class MBenchBranch : public MBench {
  typedef long long int DataType;
protected:
  long long int size;
  int pct;

  string name;

  DataType *array;
public:
  static const int NEXP = 100000;
public:
  MBenchBranch(long long int size, int pct);

  void prepare(int *indir);

  void alloc();
  void init();
  MBenchResult *run();
  void dealloc();
};

