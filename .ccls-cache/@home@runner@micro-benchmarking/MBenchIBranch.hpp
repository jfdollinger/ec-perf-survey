#pragma once

#include "MBench.hpp"

class MBenchIBranch : public MBench {
  typedef long long int DataType;
protected:
  int pct;

  DataType *array;
  int *randl;

public:
  MBenchIBranch(long long int size, int pct);

  void prepare(int *indir);
  
  void alloc();
  void init();
  MBenchResult *run();
  void dealloc();

  string toString();
};
