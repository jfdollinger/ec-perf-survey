#include "MBenchIBranch.hpp"
#include <ctime>

MBenchIBranch::MBenchIBranch(long long int size, int pct) : MBench("ibranch", size) {
  this->pct = pct;
}

void MBenchIBranch::alloc() {
  array = new DataType[size];
  randl = new int[size];
  
  srand(0);
  for(int i = 0; i < size; ++i) {
    randl[i] = i;
  }
  randomize(size, randl);
}

void MBenchIBranch::init() {
  for(int i = 0; i < size; ++i) {
    array[i] = 0;
  }
}

void MBenchIBranch::dealloc() {
  delete[] array;
  delete[] randl;
}

MBenchResult *MBenchIBranch::run() {
  Time t;
  int i, j;
  
  int *indir = new int[size];
  prepare(indir);

  void *indirect_jump[] = {&&L1, &&L2};
  t.start();
  for(j = 0; j < size; ++j) {
    goto *indirect_jump[indir[j]];
  
    L1:
      array[j] += 1;
      goto END;
    L2:
      array[j] += 2;
      goto END;
    END:
      ;

  }
  long long int duration = t.stop();

  delete[] indir;
  
  return new MBenchResult(duration);
}

void MBenchIBranch::prepare(int *indir) {
  int i, j, m = size, n = (float)m / 100.f * pct;

  for(i = 0; i < m; ++i) {
    indir[i] = i % 2;
  }
  
  srand(1);
  for(i = 0; i < n; i += 1) { 
    indir[randl[i]] = rand() % 2;
  }

}

string MBenchIBranch::toString() {
  return MBench::toString() + "," + to_string(pct);
}

