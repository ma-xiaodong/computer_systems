#include <sys/time.h>                                                           
#include <time.h>                                                               
#include <stdio.h>                                                              
#include <stdlib.h>

#define LENGTH    4096

void psum1(float *a, float *p) {
  p[0] = a[0];
  for (int i = 1; i < LENGTH; i++) {
    p[i] = p[i - 1] + a[i];
  }
  return;
}

void psum2(float *a, float *p) {
  p[0] = a[0];
  float val = a[0];
  for (int i = 1; i < LENGTH; i++) {
    p[i] = val + a[i];
    val += a[i];
  }
  return;
}

int main(int argc, char **argv) {
  struct timeval t1, t2;
  float timeuse;
  float a[LENGTH], p[LENGTH];

  for (int i = 0; i < LENGTH; i++) {
    a[i] = i / 10.0;
  }

  gettimeofday(&t1, NULL);
  psum1(a, p);
  gettimeofday(&t2, NULL);
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec)/1000000.0;        
  printf("Time used by psum1: %f\n", timeuse);

  gettimeofday(&t1, NULL);
  psum2(a, p);
  gettimeofday(&t2, NULL);
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec)/1000000.0;        
  printf("Time used by psum2: %f\n", timeuse);

/*
  // dump the result
  for (int i = 0; i < LENGTH; i++) {
    printf("%.4f : %.4f\n", a[i], p[i]);
  }
*/
}

