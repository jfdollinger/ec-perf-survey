#include "MBench.hpp"

void randomize(int m, int randl[m]) {
  int i, j;

  for (; m > 0; --m) {
    j = rand() % m;

    swap(randl[j], randl[m - 1]);
  }
}

class MBenchContext {
public:
  string name;
  MBenchContext(string name) {
    this->name = name;
  }
  virtual string toString() = 0;
};

AbstractMBenchResult::AbstractMBenchResult() {}

AbstractMBenchResult::AbstractMBenchResult(long long int duration) {
  this->duration = duration;
}

string AbstractMBenchResult::toString() {
  return std::to_string(duration);
}

MBenchResult::MBenchResult(long long int duration)
    : AbstractMBenchResult(duration) {}

bool orderMBenchResult(MBenchResult *l, MBenchResult *r) {
  return l->duration < r->duration;
}

MBenchResultAggregate::MBenchResultAggregate()
    : res(), AbstractMBenchResult(0) {}

MBenchResultAggregate::MBenchResultAggregate(long long int size, string name)
    : res(), AbstractMBenchResult(0) {
  this->size = size;
  this->name = name;
}

#define EVICT_PCT 0.4
void MBenchResultAggregate::sanitize() {
  int evict = EVICT_PCT / 2. * res.size();

  sort(res.begin(), res.end(), orderMBenchResult);

  if(res.size() != 0) {
    duration = 0;
    for (int i = evict; i < (res.size() - evict); ++i) {
      duration += res[i]->duration;
    }
    duration = duration / (res.size() - 2 * evict);
  }
  else duration = -1;
}

string MBenchResultAggregate::toString() {
  sanitize();

  return AbstractMBenchResult::toString();
}

void MBenchRunner::run(vector<MBench *> benches) {
  MBench *curr;
  MBenchResult *res;

  for (int i = 0; i < benches.size(); ++i) {
    curr = benches[i];
    
    MBenchResultAggregate mBenchResults;
    
    curr->alloc();
    for (int j = 0; j < nexp; ++j) {
      curr->init();
      res = curr->run();
      
      mBenchResults += res;
    }
    curr->dealloc();
    
    cout << curr->toString() << "," << mBenchResults.toString() << endl;
  }
}

MBench::MBench(string name, long long int size) {
  this->name = name;
  this->size = size;
}