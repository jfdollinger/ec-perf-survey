#include <iostream>

#include "MBenchBranch.hpp"
#include "MBenchFalseSharing.hpp"
#include "MBenchIBranch.hpp"
#include "MBenchMetrics.hpp"
#include "MBenchPrefetch.hpp"

#define N 2500

void mbench_prefetch() {
  MBenchRunner runner(5);

  vector<MBench *> prefetch_sequential{new MBenchPrefetchSequential(100),
                                       new MBenchPrefetchSequential(250),
                                       new MBenchPrefetchSequential(500),
                                       new MBenchPrefetchSequential(750),
                                       new MBenchPrefetchSequential(1000),
                                       new MBenchPrefetchSequential(2500),
                                       new MBenchPrefetchSequential(5000),
                                       new MBenchPrefetchSequential(7500),
                                       new MBenchPrefetchSequential(10000),
                                       new MBenchPrefetchSequential(25000),
                                       new MBenchPrefetchSequential(50000),
                                       new MBenchPrefetchSequential(75000),
                                       new MBenchPrefetchSequential(100000),
                                       new MBenchPrefetchSequential(250000),
                                       new MBenchPrefetchSequential(500000),
                                       new MBenchPrefetchSequential(750000),
                                       new MBenchPrefetchSequential(1000000),
                                       new MBenchPrefetchSequential(2500000),
                                       new MBenchPrefetchSequential(5000000),
                                       new MBenchPrefetchSequential(7500000),
                                       new MBenchPrefetchSequential(10000000),
                                       new MBenchPrefetchSequential(25000000),
                                       new MBenchPrefetchSequential(50000000)};

  vector<MBench *> prefetch_random{
      new MBenchPrefetchRandom(100),      new MBenchPrefetchRandom(250),
      new MBenchPrefetchRandom(500),      new MBenchPrefetchRandom(750),
      new MBenchPrefetchRandom(1000),     new MBenchPrefetchRandom(2500),
      new MBenchPrefetchRandom(5000),     new MBenchPrefetchRandom(7500),
      new MBenchPrefetchRandom(10000),    new MBenchPrefetchRandom(25000),
      new MBenchPrefetchRandom(50000),    new MBenchPrefetchRandom(75000),
      new MBenchPrefetchRandom(100000),   new MBenchPrefetchRandom(250000),
      new MBenchPrefetchRandom(500000),   new MBenchPrefetchRandom(750000),
      new MBenchPrefetchRandom(1000000),  new MBenchPrefetchRandom(2500000),
      new MBenchPrefetchRandom(5000000),  new MBenchPrefetchRandom(7500000),
      new MBenchPrefetchRandom(10000000), new MBenchPrefetchRandom(25000000),
      new MBenchPrefetchRandom(50000000)};

  runner.run(prefetch_sequential);
  runner.run(prefetch_random);
}

void mbench_indirect_branch() {
  MBenchRunner runner(5);

  vector<MBench *> ibranch_miss{
      new MBenchIBranch(50000000, 0),  new MBenchIBranch(50000000, 5),
      new MBenchIBranch(50000000, 10), new MBenchIBranch(50000000, 15),
      new MBenchIBranch(50000000, 20), new MBenchIBranch(50000000, 25),
      new MBenchIBranch(50000000, 30), new MBenchIBranch(50000000, 35),
      new MBenchIBranch(50000000, 40), new MBenchIBranch(50000000, 45),
      new MBenchIBranch(50000000, 50), new MBenchIBranch(50000000, 55),
      new MBenchIBranch(50000000, 60), new MBenchIBranch(50000000, 65),
      new MBenchIBranch(50000000, 70), new MBenchIBranch(50000000, 75),
      new MBenchIBranch(50000000, 80), new MBenchIBranch(50000000, 85),
      new MBenchIBranch(50000000, 90), new MBenchIBranch(50000000, 95),
      new MBenchIBranch(50000000, 100)};

  runner.run(ibranch_miss);
}

void mbench_branch() {
  MBenchRunner runner(5);

  vector<MBench *> branch_miss = {
      new MBenchBranch(50000000, 0),  new MBenchBranch(50000000, 5),
      new MBenchBranch(50000000, 10), new MBenchBranch(50000000, 15),
      new MBenchBranch(50000000, 20), new MBenchBranch(50000000, 25),
      new MBenchBranch(50000000, 30), new MBenchBranch(50000000, 35),
      new MBenchBranch(50000000, 40), new MBenchBranch(50000000, 45),
      new MBenchBranch(50000000, 50), new MBenchBranch(50000000, 55),
      new MBenchBranch(50000000, 60), new MBenchBranch(50000000, 65),
      new MBenchBranch(50000000, 70), new MBenchBranch(50000000, 75),
      new MBenchBranch(50000000, 80), new MBenchBranch(50000000, 85),
      new MBenchBranch(50000000, 90), new MBenchBranch(50000000, 95),
      new MBenchBranch(50000000, 100)};

  runner.run(branch_miss);
}

void mbench_falsesharing() {
  MBenchRunner runner(10);

  vector<MBench *> falsesharing = {
      new MBenchFalseSharing(5000000, 1, 2),
      new MBenchFalseSharing(5000000, 2, 2),
      new MBenchFalseSharing(5000000, 4, 2),
      new MBenchFalseSharing(5000000, 6, 2),
      new MBenchFalseSharing(5000000, 8, 2),
      new MBenchFalseSharing(5000000, 12, 2),
      new MBenchFalseSharing(5000000, 16, 2),
      new MBenchFalseSharing(5000000, 20, 2),
      new MBenchFalseSharing(5000000, 24, 2),
      new MBenchFalseSharing(5000000, 32, 2),
      new MBenchFalseSharing(5000000, 40, 2),
      new MBenchFalseSharing(5000000, 48, 2),
      new MBenchFalseSharing(5000000, 1, 4),
      new MBenchFalseSharing(5000000, 2, 4),
      new MBenchFalseSharing(5000000, 4, 4),
      new MBenchFalseSharing(5000000, 6, 4),
      new MBenchFalseSharing(5000000, 8, 4),
      new MBenchFalseSharing(5000000, 12, 4),
      new MBenchFalseSharing(5000000, 16, 4),
      new MBenchFalseSharing(5000000, 20, 4),
      new MBenchFalseSharing(5000000, 24, 4),
      new MBenchFalseSharing(5000000, 32, 4),
      new MBenchFalseSharing(5000000, 40, 4),
      new MBenchFalseSharing(5000000, 48, 4),
      new MBenchFalseSharing(5000000, 1, 8),
      new MBenchFalseSharing(5000000, 2, 8),
      new MBenchFalseSharing(5000000, 4, 8),
      new MBenchFalseSharing(5000000, 6, 8),
      new MBenchFalseSharing(5000000, 8, 8),
      new MBenchFalseSharing(5000000, 12, 8),
      new MBenchFalseSharing(5000000, 16, 8),
      new MBenchFalseSharing(5000000, 20, 8),
      new MBenchFalseSharing(5000000, 24, 8),
      new MBenchFalseSharing(5000000, 32, 8),
      new MBenchFalseSharing(5000000, 40, 8),
      new MBenchFalseSharing(5000000, 48, 8),
      new MBenchFalseSharing(5000000, 1, 16),
      new MBenchFalseSharing(5000000, 2, 16),
      new MBenchFalseSharing(5000000, 4, 16),
      new MBenchFalseSharing(5000000, 6, 16),
      new MBenchFalseSharing(5000000, 8, 16),
      new MBenchFalseSharing(5000000, 12, 16),
      new MBenchFalseSharing(5000000, 16, 16),
      new MBenchFalseSharing(5000000, 20, 16),
      new MBenchFalseSharing(5000000, 24, 16),
      new MBenchFalseSharing(5000000, 32, 16),
      new MBenchFalseSharing(5000000, 40, 16),
      new MBenchFalseSharing(5000000, 48, 16),
  };

  runner.run(falsesharing);
}

int main() {

  mbench_prefetch();
  mbench_branch();
  mbench_indirect_branch();
  mbench_falsesharing();

  return 0;
}