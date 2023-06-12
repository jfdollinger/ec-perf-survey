#include "gemm_kernel.hu"
__global__ void kernel0(double *A, double *B, double *C, double alpha, double beta, int nj, int nk, int ni)
{
    int b0 = blockIdx.y, b1 = blockIdx.x;
    int t0 = threadIdx.y, t1 = threadIdx.x;
    double private_C[8][8];

    #define ppcg_min(x,y)    ({ __typeof__(x) _x = (x); __typeof__(y) _y = (y); _x < _y ? _x : _y; })
    for (int c0 = 256 * b0; c0 < ni; c0 += 65536)
      for (int c1 = 256 * b1; c1 < nj; c1 += 65536) {
        if (ni >= t0 + c0 + 1 && nj >= t1 + c1 + 1) {
          private_C[0][0] = C[(t0 + c0) * nj + (t1 + c1)];
          if (nj >= t1 + c1 + 33) {
            private_C[0][1] = C[(t0 + c0) * nj + (t1 + c1 + 32)];
            if (nj >= t1 + c1 + 65) {
              private_C[0][2] = C[(t0 + c0) * nj + (t1 + c1 + 64)];
              if (nj >= t1 + c1 + 97) {
                private_C[0][3] = C[(t0 + c0) * nj + (t1 + c1 + 96)];
                if (nj >= t1 + c1 + 129) {
                  private_C[0][4] = C[(t0 + c0) * nj + (t1 + c1 + 128)];
                  if (nj >= t1 + c1 + 161) {
                    private_C[0][5] = C[(t0 + c0) * nj + (t1 + c1 + 160)];
                    if (nj >= t1 + c1 + 193) {
                      private_C[0][6] = C[(t0 + c0) * nj + (t1 + c1 + 192)];
                      if (nj >= t1 + c1 + 225)
                        private_C[0][7] = C[(t0 + c0) * nj + (t1 + c1 + 224)];
                    }
                  }
                }
              }
            }
          }
          if (ni >= t0 + c0 + 33) {
            private_C[1][0] = C[(t0 + c0 + 32) * nj + (t1 + c1)];
            if (nj >= t1 + c1 + 33) {
              private_C[1][1] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 32)];
              if (nj >= t1 + c1 + 65) {
                private_C[1][2] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 64)];
                if (nj >= t1 + c1 + 97) {
                  private_C[1][3] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 96)];
                  if (nj >= t1 + c1 + 129) {
                    private_C[1][4] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 128)];
                    if (nj >= t1 + c1 + 161) {
                      private_C[1][5] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 160)];
                      if (nj >= t1 + c1 + 193) {
                        private_C[1][6] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 192)];
                        if (nj >= t1 + c1 + 225)
                          private_C[1][7] = C[(t0 + c0 + 32) * nj + (t1 + c1 + 224)];
                      }
                    }
                  }
                }
              }
            }
            if (ni >= t0 + c0 + 65) {
              private_C[2][0] = C[(t0 + c0 + 64) * nj + (t1 + c1)];
              if (nj >= t1 + c1 + 33) {
                private_C[2][1] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 32)];
                if (nj >= t1 + c1 + 65) {
                  private_C[2][2] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 64)];
                  if (nj >= t1 + c1 + 97) {
                    private_C[2][3] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 96)];
                    if (nj >= t1 + c1 + 129) {
                      private_C[2][4] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 128)];
                      if (nj >= t1 + c1 + 161) {
                        private_C[2][5] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 160)];
                        if (nj >= t1 + c1 + 193) {
                          private_C[2][6] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 192)];
                          if (nj >= t1 + c1 + 225)
                            private_C[2][7] = C[(t0 + c0 + 64) * nj + (t1 + c1 + 224)];
                        }
                      }
                    }
                  }
                }
              }
              if (ni >= t0 + c0 + 97) {
                private_C[3][0] = C[(t0 + c0 + 96) * nj + (t1 + c1)];
                if (nj >= t1 + c1 + 33) {
                  private_C[3][1] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 32)];
                  if (nj >= t1 + c1 + 65) {
                    private_C[3][2] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 64)];
                    if (nj >= t1 + c1 + 97) {
                      private_C[3][3] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 96)];
                      if (nj >= t1 + c1 + 129) {
                        private_C[3][4] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 128)];
                        if (nj >= t1 + c1 + 161) {
                          private_C[3][5] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 160)];
                          if (nj >= t1 + c1 + 193) {
                            private_C[3][6] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 192)];
                            if (nj >= t1 + c1 + 225)
                              private_C[3][7] = C[(t0 + c0 + 96) * nj + (t1 + c1 + 224)];
                          }
                        }
                      }
                    }
                  }
                }
                if (ni >= t0 + c0 + 129) {
                  private_C[4][0] = C[(t0 + c0 + 128) * nj + (t1 + c1)];
                  if (nj >= t1 + c1 + 33) {
                    private_C[4][1] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 32)];
                    if (nj >= t1 + c1 + 65) {
                      private_C[4][2] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 64)];
                      if (nj >= t1 + c1 + 97) {
                        private_C[4][3] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 96)];
                        if (nj >= t1 + c1 + 129) {
                          private_C[4][4] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 128)];
                          if (nj >= t1 + c1 + 161) {
                            private_C[4][5] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 160)];
                            if (nj >= t1 + c1 + 193) {
                              private_C[4][6] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 192)];
                              if (nj >= t1 + c1 + 225)
                                private_C[4][7] = C[(t0 + c0 + 128) * nj + (t1 + c1 + 224)];
                            }
                          }
                        }
                      }
                    }
                  }
                  if (ni >= t0 + c0 + 161) {
                    private_C[5][0] = C[(t0 + c0 + 160) * nj + (t1 + c1)];
                    if (nj >= t1 + c1 + 33) {
                      private_C[5][1] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 32)];
                      if (nj >= t1 + c1 + 65) {
                        private_C[5][2] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 64)];
                        if (nj >= t1 + c1 + 97) {
                          private_C[5][3] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 96)];
                          if (nj >= t1 + c1 + 129) {
                            private_C[5][4] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 128)];
                            if (nj >= t1 + c1 + 161) {
                              private_C[5][5] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 160)];
                              if (nj >= t1 + c1 + 193) {
                                private_C[5][6] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 192)];
                                if (nj >= t1 + c1 + 225)
                                  private_C[5][7] = C[(t0 + c0 + 160) * nj + (t1 + c1 + 224)];
                              }
                            }
                          }
                        }
                      }
                    }
                    if (ni >= t0 + c0 + 193) {
                      private_C[6][0] = C[(t0 + c0 + 192) * nj + (t1 + c1)];
                      if (nj >= t1 + c1 + 33) {
                        private_C[6][1] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 32)];
                        if (nj >= t1 + c1 + 65) {
                          private_C[6][2] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 64)];
                          if (nj >= t1 + c1 + 97) {
                            private_C[6][3] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 96)];
                            if (nj >= t1 + c1 + 129) {
                              private_C[6][4] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 128)];
                              if (nj >= t1 + c1 + 161) {
                                private_C[6][5] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 160)];
                                if (nj >= t1 + c1 + 193) {
                                  private_C[6][6] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 192)];
                                  if (nj >= t1 + c1 + 225)
                                    private_C[6][7] = C[(t0 + c0 + 192) * nj + (t1 + c1 + 224)];
                                }
                              }
                            }
                          }
                        }
                      }
                      if (ni >= t0 + c0 + 225) {
                        private_C[7][0] = C[(t0 + c0 + 224) * nj + (t1 + c1)];
                        if (nj >= t1 + c1 + 33) {
                          private_C[7][1] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 32)];
                          if (nj >= t1 + c1 + 65) {
                            private_C[7][2] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 64)];
                            if (nj >= t1 + c1 + 97) {
                              private_C[7][3] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 96)];
                              if (nj >= t1 + c1 + 129) {
                                private_C[7][4] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 128)];
                                if (nj >= t1 + c1 + 161) {
                                  private_C[7][5] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 160)];
                                  if (nj >= t1 + c1 + 193) {
                                    private_C[7][6] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 192)];
                                    if (nj >= t1 + c1 + 225)
                                      private_C[7][7] = C[(t0 + c0 + 224) * nj + (t1 + c1 + 224)];
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          private_C[0][0] *= beta;
          if (nj >= t1 + c1 + 33) {
            private_C[0][1] *= beta;
            if (nj >= t1 + c1 + 65) {
              private_C[0][2] *= beta;
              if (nj >= t1 + c1 + 97) {
                private_C[0][3] *= beta;
                if (nj >= t1 + c1 + 129) {
                  private_C[0][4] *= beta;
                  if (nj >= t1 + c1 + 161) {
                    private_C[0][5] *= beta;
                    if (nj >= t1 + c1 + 193) {
                      private_C[0][6] *= beta;
                      if (nj >= t1 + c1 + 225)
                        private_C[0][7] *= beta;
                    }
                  }
                }
              }
            }
          }
          if (ni >= t0 + c0 + 33) {
            private_C[1][0] *= beta;
            if (nj >= t1 + c1 + 33) {
              private_C[1][1] *= beta;
              if (nj >= t1 + c1 + 65) {
                private_C[1][2] *= beta;
                if (nj >= t1 + c1 + 97) {
                  private_C[1][3] *= beta;
                  if (nj >= t1 + c1 + 129) {
                    private_C[1][4] *= beta;
                    if (nj >= t1 + c1 + 161) {
                      private_C[1][5] *= beta;
                      if (nj >= t1 + c1 + 193) {
                        private_C[1][6] *= beta;
                        if (nj >= t1 + c1 + 225)
                          private_C[1][7] *= beta;
                      }
                    }
                  }
                }
              }
            }
            if (ni >= t0 + c0 + 65) {
              private_C[2][0] *= beta;
              if (nj >= t1 + c1 + 33) {
                private_C[2][1] *= beta;
                if (nj >= t1 + c1 + 65) {
                  private_C[2][2] *= beta;
                  if (nj >= t1 + c1 + 97) {
                    private_C[2][3] *= beta;
                    if (nj >= t1 + c1 + 129) {
                      private_C[2][4] *= beta;
                      if (nj >= t1 + c1 + 161) {
                        private_C[2][5] *= beta;
                        if (nj >= t1 + c1 + 193) {
                          private_C[2][6] *= beta;
                          if (nj >= t1 + c1 + 225)
                            private_C[2][7] *= beta;
                        }
                      }
                    }
                  }
                }
              }
              if (ni >= t0 + c0 + 97) {
                private_C[3][0] *= beta;
                if (nj >= t1 + c1 + 33) {
                  private_C[3][1] *= beta;
                  if (nj >= t1 + c1 + 65) {
                    private_C[3][2] *= beta;
                    if (nj >= t1 + c1 + 97) {
                      private_C[3][3] *= beta;
                      if (nj >= t1 + c1 + 129) {
                        private_C[3][4] *= beta;
                        if (nj >= t1 + c1 + 161) {
                          private_C[3][5] *= beta;
                          if (nj >= t1 + c1 + 193) {
                            private_C[3][6] *= beta;
                            if (nj >= t1 + c1 + 225)
                              private_C[3][7] *= beta;
                          }
                        }
                      }
                    }
                  }
                }
                if (ni >= t0 + c0 + 129) {
                  private_C[4][0] *= beta;
                  if (nj >= t1 + c1 + 33) {
                    private_C[4][1] *= beta;
                    if (nj >= t1 + c1 + 65) {
                      private_C[4][2] *= beta;
                      if (nj >= t1 + c1 + 97) {
                        private_C[4][3] *= beta;
                        if (nj >= t1 + c1 + 129) {
                          private_C[4][4] *= beta;
                          if (nj >= t1 + c1 + 161) {
                            private_C[4][5] *= beta;
                            if (nj >= t1 + c1 + 193) {
                              private_C[4][6] *= beta;
                              if (nj >= t1 + c1 + 225)
                                private_C[4][7] *= beta;
                            }
                          }
                        }
                      }
                    }
                  }
                  if (ni >= t0 + c0 + 161) {
                    private_C[5][0] *= beta;
                    if (nj >= t1 + c1 + 33) {
                      private_C[5][1] *= beta;
                      if (nj >= t1 + c1 + 65) {
                        private_C[5][2] *= beta;
                        if (nj >= t1 + c1 + 97) {
                          private_C[5][3] *= beta;
                          if (nj >= t1 + c1 + 129) {
                            private_C[5][4] *= beta;
                            if (nj >= t1 + c1 + 161) {
                              private_C[5][5] *= beta;
                              if (nj >= t1 + c1 + 193) {
                                private_C[5][6] *= beta;
                                if (nj >= t1 + c1 + 225)
                                  private_C[5][7] *= beta;
                              }
                            }
                          }
                        }
                      }
                    }
                    if (ni >= t0 + c0 + 193) {
                      private_C[6][0] *= beta;
                      if (nj >= t1 + c1 + 33) {
                        private_C[6][1] *= beta;
                        if (nj >= t1 + c1 + 65) {
                          private_C[6][2] *= beta;
                          if (nj >= t1 + c1 + 97) {
                            private_C[6][3] *= beta;
                            if (nj >= t1 + c1 + 129) {
                              private_C[6][4] *= beta;
                              if (nj >= t1 + c1 + 161) {
                                private_C[6][5] *= beta;
                                if (nj >= t1 + c1 + 193) {
                                  private_C[6][6] *= beta;
                                  if (nj >= t1 + c1 + 225)
                                    private_C[6][7] *= beta;
                                }
                              }
                            }
                          }
                        }
                      }
                      if (ni >= t0 + c0 + 225) {
                        private_C[7][0] *= beta;
                        if (nj >= t1 + c1 + 33) {
                          private_C[7][1] *= beta;
                          if (nj >= t1 + c1 + 65) {
                            private_C[7][2] *= beta;
                            if (nj >= t1 + c1 + 97) {
                              private_C[7][3] *= beta;
                              if (nj >= t1 + c1 + 129) {
                                private_C[7][4] *= beta;
                                if (nj >= t1 + c1 + 161) {
                                  private_C[7][5] *= beta;
                                  if (nj >= t1 + c1 + 193) {
                                    private_C[7][6] *= beta;
                                    if (nj >= t1 + c1 + 225)
                                      private_C[7][7] *= beta;
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          for (int c2 = 0; c2 < nk; c2 += 256)
            for (int c3 = 0; c3 <= ppcg_min(255, nk - c2 - 1); c3 += 1) {
              private_C[0][0] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
              if (nj >= t1 + c1 + 33) {
                private_C[0][1] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                if (nj >= t1 + c1 + 65) {
                  private_C[0][2] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                  if (nj >= t1 + c1 + 97) {
                    private_C[0][3] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                    if (nj >= t1 + c1 + 129) {
                      private_C[0][4] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                      if (nj >= t1 + c1 + 161) {
                        private_C[0][5] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                        if (nj >= t1 + c1 + 193) {
                          private_C[0][6] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                          if (nj >= t1 + c1 + 225)
                            private_C[0][7] += ((alpha * A[(t0 + c0) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                        }
                      }
                    }
                  }
                }
              }
              if (ni >= t0 + c0 + 33) {
                private_C[1][0] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                if (nj >= t1 + c1 + 33) {
                  private_C[1][1] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                  if (nj >= t1 + c1 + 65) {
                    private_C[1][2] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                    if (nj >= t1 + c1 + 97) {
                      private_C[1][3] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                      if (nj >= t1 + c1 + 129) {
                        private_C[1][4] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                        if (nj >= t1 + c1 + 161) {
                          private_C[1][5] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                          if (nj >= t1 + c1 + 193) {
                            private_C[1][6] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                            if (nj >= t1 + c1 + 225)
                              private_C[1][7] += ((alpha * A[(t0 + c0 + 32) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                          }
                        }
                      }
                    }
                  }
                }
                if (ni >= t0 + c0 + 65) {
                  private_C[2][0] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                  if (nj >= t1 + c1 + 33) {
                    private_C[2][1] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                    if (nj >= t1 + c1 + 65) {
                      private_C[2][2] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                      if (nj >= t1 + c1 + 97) {
                        private_C[2][3] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                        if (nj >= t1 + c1 + 129) {
                          private_C[2][4] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                          if (nj >= t1 + c1 + 161) {
                            private_C[2][5] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                            if (nj >= t1 + c1 + 193) {
                              private_C[2][6] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                              if (nj >= t1 + c1 + 225)
                                private_C[2][7] += ((alpha * A[(t0 + c0 + 64) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                            }
                          }
                        }
                      }
                    }
                  }
                  if (ni >= t0 + c0 + 97) {
                    private_C[3][0] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                    if (nj >= t1 + c1 + 33) {
                      private_C[3][1] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                      if (nj >= t1 + c1 + 65) {
                        private_C[3][2] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                        if (nj >= t1 + c1 + 97) {
                          private_C[3][3] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                          if (nj >= t1 + c1 + 129) {
                            private_C[3][4] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                            if (nj >= t1 + c1 + 161) {
                              private_C[3][5] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                              if (nj >= t1 + c1 + 193) {
                                private_C[3][6] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                                if (nj >= t1 + c1 + 225)
                                  private_C[3][7] += ((alpha * A[(t0 + c0 + 96) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                              }
                            }
                          }
                        }
                      }
                    }
                    if (ni >= t0 + c0 + 129) {
                      private_C[4][0] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                      if (nj >= t1 + c1 + 33) {
                        private_C[4][1] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                        if (nj >= t1 + c1 + 65) {
                          private_C[4][2] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                          if (nj >= t1 + c1 + 97) {
                            private_C[4][3] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                            if (nj >= t1 + c1 + 129) {
                              private_C[4][4] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                              if (nj >= t1 + c1 + 161) {
                                private_C[4][5] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                                if (nj >= t1 + c1 + 193) {
                                  private_C[4][6] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                                  if (nj >= t1 + c1 + 225)
                                    private_C[4][7] += ((alpha * A[(t0 + c0 + 128) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                                }
                              }
                            }
                          }
                        }
                      }
                      if (ni >= t0 + c0 + 161) {
                        private_C[5][0] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                        if (nj >= t1 + c1 + 33) {
                          private_C[5][1] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                          if (nj >= t1 + c1 + 65) {
                            private_C[5][2] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                            if (nj >= t1 + c1 + 97) {
                              private_C[5][3] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                              if (nj >= t1 + c1 + 129) {
                                private_C[5][4] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                                if (nj >= t1 + c1 + 161) {
                                  private_C[5][5] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                                  if (nj >= t1 + c1 + 193) {
                                    private_C[5][6] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                                    if (nj >= t1 + c1 + 225)
                                      private_C[5][7] += ((alpha * A[(t0 + c0 + 160) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                                  }
                                }
                              }
                            }
                          }
                        }
                        if (ni >= t0 + c0 + 193) {
                          private_C[6][0] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                          if (nj >= t1 + c1 + 33) {
                            private_C[6][1] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                            if (nj >= t1 + c1 + 65) {
                              private_C[6][2] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                              if (nj >= t1 + c1 + 97) {
                                private_C[6][3] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                                if (nj >= t1 + c1 + 129) {
                                  private_C[6][4] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                                  if (nj >= t1 + c1 + 161) {
                                    private_C[6][5] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                                    if (nj >= t1 + c1 + 193) {
                                      private_C[6][6] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                                      if (nj >= t1 + c1 + 225)
                                        private_C[6][7] += ((alpha * A[(t0 + c0 + 192) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                                    }
                                  }
                                }
                              }
                            }
                          }
                          if (ni >= t0 + c0 + 225) {
                            private_C[7][0] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1)]);
                            if (nj >= t1 + c1 + 33) {
                              private_C[7][1] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 32)]);
                              if (nj >= t1 + c1 + 65) {
                                private_C[7][2] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 64)]);
                                if (nj >= t1 + c1 + 97) {
                                  private_C[7][3] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 96)]);
                                  if (nj >= t1 + c1 + 129) {
                                    private_C[7][4] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 128)]);
                                    if (nj >= t1 + c1 + 161) {
                                      private_C[7][5] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 160)]);
                                      if (nj >= t1 + c1 + 193) {
                                        private_C[7][6] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 192)]);
                                        if (nj >= t1 + c1 + 225)
                                          private_C[7][7] += ((alpha * A[(t0 + c0 + 224) * nk + (c2 + c3)]) * B[(c2 + c3) * nj + (t1 + c1 + 224)]);
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          C[(t0 + c0) * nj + (t1 + c1)] = private_C[0][0];
          if (nj >= t1 + c1 + 33) {
            C[(t0 + c0) * nj + (t1 + c1 + 32)] = private_C[0][1];
            if (nj >= t1 + c1 + 65) {
              C[(t0 + c0) * nj + (t1 + c1 + 64)] = private_C[0][2];
              if (nj >= t1 + c1 + 97) {
                C[(t0 + c0) * nj + (t1 + c1 + 96)] = private_C[0][3];
                if (nj >= t1 + c1 + 129) {
                  C[(t0 + c0) * nj + (t1 + c1 + 128)] = private_C[0][4];
                  if (nj >= t1 + c1 + 161) {
                    C[(t0 + c0) * nj + (t1 + c1 + 160)] = private_C[0][5];
                    if (nj >= t1 + c1 + 193) {
                      C[(t0 + c0) * nj + (t1 + c1 + 192)] = private_C[0][6];
                      if (nj >= t1 + c1 + 225)
                        C[(t0 + c0) * nj + (t1 + c1 + 224)] = private_C[0][7];
                    }
                  }
                }
              }
            }
          }
          if (ni >= t0 + c0 + 33) {
            C[(t0 + c0 + 32) * nj + (t1 + c1)] = private_C[1][0];
            if (nj >= t1 + c1 + 33) {
              C[(t0 + c0 + 32) * nj + (t1 + c1 + 32)] = private_C[1][1];
              if (nj >= t1 + c1 + 65) {
                C[(t0 + c0 + 32) * nj + (t1 + c1 + 64)] = private_C[1][2];
                if (nj >= t1 + c1 + 97) {
                  C[(t0 + c0 + 32) * nj + (t1 + c1 + 96)] = private_C[1][3];
                  if (nj >= t1 + c1 + 129) {
                    C[(t0 + c0 + 32) * nj + (t1 + c1 + 128)] = private_C[1][4];
                    if (nj >= t1 + c1 + 161) {
                      C[(t0 + c0 + 32) * nj + (t1 + c1 + 160)] = private_C[1][5];
                      if (nj >= t1 + c1 + 193) {
                        C[(t0 + c0 + 32) * nj + (t1 + c1 + 192)] = private_C[1][6];
                        if (nj >= t1 + c1 + 225)
                          C[(t0 + c0 + 32) * nj + (t1 + c1 + 224)] = private_C[1][7];
                      }
                    }
                  }
                }
              }
            }
            if (ni >= t0 + c0 + 65) {
              C[(t0 + c0 + 64) * nj + (t1 + c1)] = private_C[2][0];
              if (nj >= t1 + c1 + 33) {
                C[(t0 + c0 + 64) * nj + (t1 + c1 + 32)] = private_C[2][1];
                if (nj >= t1 + c1 + 65) {
                  C[(t0 + c0 + 64) * nj + (t1 + c1 + 64)] = private_C[2][2];
                  if (nj >= t1 + c1 + 97) {
                    C[(t0 + c0 + 64) * nj + (t1 + c1 + 96)] = private_C[2][3];
                    if (nj >= t1 + c1 + 129) {
                      C[(t0 + c0 + 64) * nj + (t1 + c1 + 128)] = private_C[2][4];
                      if (nj >= t1 + c1 + 161) {
                        C[(t0 + c0 + 64) * nj + (t1 + c1 + 160)] = private_C[2][5];
                        if (nj >= t1 + c1 + 193) {
                          C[(t0 + c0 + 64) * nj + (t1 + c1 + 192)] = private_C[2][6];
                          if (nj >= t1 + c1 + 225)
                            C[(t0 + c0 + 64) * nj + (t1 + c1 + 224)] = private_C[2][7];
                        }
                      }
                    }
                  }
                }
              }
              if (ni >= t0 + c0 + 97) {
                C[(t0 + c0 + 96) * nj + (t1 + c1)] = private_C[3][0];
                if (nj >= t1 + c1 + 33) {
                  C[(t0 + c0 + 96) * nj + (t1 + c1 + 32)] = private_C[3][1];
                  if (nj >= t1 + c1 + 65) {
                    C[(t0 + c0 + 96) * nj + (t1 + c1 + 64)] = private_C[3][2];
                    if (nj >= t1 + c1 + 97) {
                      C[(t0 + c0 + 96) * nj + (t1 + c1 + 96)] = private_C[3][3];
                      if (nj >= t1 + c1 + 129) {
                        C[(t0 + c0 + 96) * nj + (t1 + c1 + 128)] = private_C[3][4];
                        if (nj >= t1 + c1 + 161) {
                          C[(t0 + c0 + 96) * nj + (t1 + c1 + 160)] = private_C[3][5];
                          if (nj >= t1 + c1 + 193) {
                            C[(t0 + c0 + 96) * nj + (t1 + c1 + 192)] = private_C[3][6];
                            if (nj >= t1 + c1 + 225)
                              C[(t0 + c0 + 96) * nj + (t1 + c1 + 224)] = private_C[3][7];
                          }
                        }
                      }
                    }
                  }
                }
                if (ni >= t0 + c0 + 129) {
                  C[(t0 + c0 + 128) * nj + (t1 + c1)] = private_C[4][0];
                  if (nj >= t1 + c1 + 33) {
                    C[(t0 + c0 + 128) * nj + (t1 + c1 + 32)] = private_C[4][1];
                    if (nj >= t1 + c1 + 65) {
                      C[(t0 + c0 + 128) * nj + (t1 + c1 + 64)] = private_C[4][2];
                      if (nj >= t1 + c1 + 97) {
                        C[(t0 + c0 + 128) * nj + (t1 + c1 + 96)] = private_C[4][3];
                        if (nj >= t1 + c1 + 129) {
                          C[(t0 + c0 + 128) * nj + (t1 + c1 + 128)] = private_C[4][4];
                          if (nj >= t1 + c1 + 161) {
                            C[(t0 + c0 + 128) * nj + (t1 + c1 + 160)] = private_C[4][5];
                            if (nj >= t1 + c1 + 193) {
                              C[(t0 + c0 + 128) * nj + (t1 + c1 + 192)] = private_C[4][6];
                              if (nj >= t1 + c1 + 225)
                                C[(t0 + c0 + 128) * nj + (t1 + c1 + 224)] = private_C[4][7];
                            }
                          }
                        }
                      }
                    }
                  }
                  if (ni >= t0 + c0 + 161) {
                    C[(t0 + c0 + 160) * nj + (t1 + c1)] = private_C[5][0];
                    if (nj >= t1 + c1 + 33) {
                      C[(t0 + c0 + 160) * nj + (t1 + c1 + 32)] = private_C[5][1];
                      if (nj >= t1 + c1 + 65) {
                        C[(t0 + c0 + 160) * nj + (t1 + c1 + 64)] = private_C[5][2];
                        if (nj >= t1 + c1 + 97) {
                          C[(t0 + c0 + 160) * nj + (t1 + c1 + 96)] = private_C[5][3];
                          if (nj >= t1 + c1 + 129) {
                            C[(t0 + c0 + 160) * nj + (t1 + c1 + 128)] = private_C[5][4];
                            if (nj >= t1 + c1 + 161) {
                              C[(t0 + c0 + 160) * nj + (t1 + c1 + 160)] = private_C[5][5];
                              if (nj >= t1 + c1 + 193) {
                                C[(t0 + c0 + 160) * nj + (t1 + c1 + 192)] = private_C[5][6];
                                if (nj >= t1 + c1 + 225)
                                  C[(t0 + c0 + 160) * nj + (t1 + c1 + 224)] = private_C[5][7];
                              }
                            }
                          }
                        }
                      }
                    }
                    if (ni >= t0 + c0 + 193) {
                      C[(t0 + c0 + 192) * nj + (t1 + c1)] = private_C[6][0];
                      if (nj >= t1 + c1 + 33) {
                        C[(t0 + c0 + 192) * nj + (t1 + c1 + 32)] = private_C[6][1];
                        if (nj >= t1 + c1 + 65) {
                          C[(t0 + c0 + 192) * nj + (t1 + c1 + 64)] = private_C[6][2];
                          if (nj >= t1 + c1 + 97) {
                            C[(t0 + c0 + 192) * nj + (t1 + c1 + 96)] = private_C[6][3];
                            if (nj >= t1 + c1 + 129) {
                              C[(t0 + c0 + 192) * nj + (t1 + c1 + 128)] = private_C[6][4];
                              if (nj >= t1 + c1 + 161) {
                                C[(t0 + c0 + 192) * nj + (t1 + c1 + 160)] = private_C[6][5];
                                if (nj >= t1 + c1 + 193) {
                                  C[(t0 + c0 + 192) * nj + (t1 + c1 + 192)] = private_C[6][6];
                                  if (nj >= t1 + c1 + 225)
                                    C[(t0 + c0 + 192) * nj + (t1 + c1 + 224)] = private_C[6][7];
                                }
                              }
                            }
                          }
                        }
                      }
                      if (ni >= t0 + c0 + 225) {
                        C[(t0 + c0 + 224) * nj + (t1 + c1)] = private_C[7][0];
                        if (nj >= t1 + c1 + 33) {
                          C[(t0 + c0 + 224) * nj + (t1 + c1 + 32)] = private_C[7][1];
                          if (nj >= t1 + c1 + 65) {
                            C[(t0 + c0 + 224) * nj + (t1 + c1 + 64)] = private_C[7][2];
                            if (nj >= t1 + c1 + 97) {
                              C[(t0 + c0 + 224) * nj + (t1 + c1 + 96)] = private_C[7][3];
                              if (nj >= t1 + c1 + 129) {
                                C[(t0 + c0 + 224) * nj + (t1 + c1 + 128)] = private_C[7][4];
                                if (nj >= t1 + c1 + 161) {
                                  C[(t0 + c0 + 224) * nj + (t1 + c1 + 160)] = private_C[7][5];
                                  if (nj >= t1 + c1 + 193) {
                                    C[(t0 + c0 + 224) * nj + (t1 + c1 + 192)] = private_C[7][6];
                                    if (nj >= t1 + c1 + 225)
                                      C[(t0 + c0 + 224) * nj + (t1 + c1 + 224)] = private_C[7][7];
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        __syncthreads();
      }
}
