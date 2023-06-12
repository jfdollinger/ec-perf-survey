#include "MBenchBranch.hpp"
#include <ctime>

MBenchBranch::MBenchBranch(long long int size, int pct) : MBench("branch", size) {
  this->pct = pct;
}

void MBenchBranch::alloc() {
  array = new DataType[size];
}

void MBenchBranch::init() {
  for(int i = 0; i < size; ++i) {
    array[i] = 0;
  }
}

void MBenchBranch::dealloc() {
  delete[] array;
}

MBenchResult *MBenchBranch::run() {
  Time t;
  int i, j;
  
  int *indir = new int[size];
  prepare(indir);

  t.start();
  for(j = 0; j < size; ++j) {
    if(indir[j]) {
      array[j] += 1;
    }
    else {
      array[j] += 2;
    }
  }
  long long int duration = t.stop();

  delete[] indir;
  
  return new MBenchResult(duration);
}

void MBenchBranch::prepare(int *indir) {
  int i, j, m = size, n = (float)m / 100.f * pct;
  int *randl = new int[m];

  for(i = 0; i < m; ++i) {
    indir[i] = i % 2;
  }
  
  srand(0);
  for(i = 0; i < m; ++i) {
    randl[i] = i;
  }
  randomize(m, randl);

  for(i = 0; i < n; i += 1) { 
    //swap(indir[randl[i - 1]], indir[randl[i]]);
    indir[randl[i]] = rand() % 2;
  }

  delete[] randl;
}

