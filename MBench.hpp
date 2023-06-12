#pragma once

#include <iostream>
#include <chrono>

#include <algorithm>
#include <vector>

using namespace std;

class AbstractMBenchResult {
protected:
  double duration;
  
protected:
  AbstractMBenchResult();
public:
  AbstractMBenchResult(long long int duration);
  string toString();
};

class MBenchResult : public AbstractMBenchResult {
friend class MBenchResultAggregate;
friend bool orderMBenchResult(MBenchResult *l, MBenchResult *r);

public:
  MBenchResult(long long int duration);
};

class MBench;
class MBenchResultAggregate : public AbstractMBenchResult {
private:
  long long int size;
  string name;

  vector<MBenchResult *> res;

public:
  MBenchResultAggregate();
  MBenchResultAggregate(long long int size, string name);

  MBenchResultAggregate &operator +=(MBenchResult *r) {
    res.push_back(r);
    
    return *this;
  }
  void sanitize();
  string toString();
};

class MBench {
  public:
  string name;
  long long int size;

  MBench(string name, long long int size);
  virtual void alloc() = 0;
  virtual void init() = 0;
  virtual MBenchResult *run() = 0;
  virtual void dealloc() = 0;

  virtual string toString() {
    return name + ":" + to_string(size);
  }
};

class Time {
public:
  typedef std::chrono::high_resolution_clock Clock;
  typedef std::chrono::high_resolution_clock::time_point TimePoint;
private:
  TimePoint start_clock;
public:
  void start() {
      start_clock = Clock::now();
  }
  long long int stop() {
    TimePoint stop = Clock::now();
    std::chrono::nanoseconds diff = stop - start_clock;
    
    return diff.count();
  }
};

class MBenchRunner {
private:
  long long int nexp;

public:
  MBenchRunner(long long int nexp) {
    this->nexp = nexp;
  }

  void run(vector<MBench *> benches);
};

void randomize(int m, int randl[m]);