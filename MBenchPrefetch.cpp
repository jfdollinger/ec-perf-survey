#include "MBenchPrefetch.hpp"

MBenchPrefetch::MBenchPrefetch(long long int size) : MBench("prefetch", size) { this->size = size; }

void MBenchPrefetch::alloc() {
  array = new DataType[size]; // { 0 };
}

void MBenchPrefetch::init() {
  for (int i = 0; i < size; ++i) {
    array[i] = 0;
  }
}

void MBenchPrefetch::dealloc() { delete[] array; }

MBenchResult *MBenchPrefetch::run() {
  Time t;
  int i, j;

  int *indir = new int[size];
  prepare(indir);

  t.start();
  for (i = 0; i < NEXP; ++i) {
    for (j = 0; j < size; ++j) {
      array[indir[j]] += i * j;
    }
  }
  long long int duration = t.stop();

  delete[] indir;

  return new MBenchResult(duration);
}

MBenchPrefetch::~MBenchPrefetch() {}

void MBenchPrefetchSequential::prepare(int *indir) {
  int i;

  for (i = 0; i < size; ++i) {
    indir[i] = i;
  }
}

void MBenchPrefetchRandom::prepare(int *indir) {
  int i;

  srand(0);
  for (i = 0; i < size; ++i) {
    indir[i] = i;
  }

  randomize(size, indir);

  // indir[0] = 0;
  // for (i = 1; i < size; ++i) {
  //   indir[i] = (indir[i - 1] + rand() % (size - 1);
  //   // indir[i] = rand() % size;
  // }
}