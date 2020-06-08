#include <sys/time.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define LENGTH    4096
typedef float     TYPE;

void minmax1(TYPE *a, TYPE *b) {
  for (int i = 0; i < LENGTH; i++) {
    if (a[i] > b[i]) {
      TYPE t = a[i];
      a[i] = b[i];
      b[i] = t;
    }
  }

  return;
}

void minmax2(TYPE *a, TYPE *b) {
  for (int i = 0; i < LENGTH; i++) {
    TYPE min = a[i] < b[i] ? a[i] : b[i];
    TYPE max = a[i] < b[i] ? b[i] : a[i];
    a[i] = min;
    b[i] = max;
  }

  return;
}

/*
void dump(float *a, float *b) {
  for (int i = 0; i < LENGTH; i++) {
    printf("%.2f : %.2f\n", a[i], b[i]);
  }
}
*/

void initial(TYPE *a, TYPE *b) {
  TYPE val;
  srand((int)time(0));
  for (int i = 0; i < LENGTH; i++) {
    val = rand() / (RAND_MAX / 10.0);
    a[i] = val;
    b[i] = 10 - val;
  }
  return;
}

int main(int argc, char **argv) {
  TYPE a[LENGTH], b[LENGTH];
  struct timeval t1,t2;
  float timeuse;

  initial(a, b);
  gettimeofday(&t1, NULL);
  minmax1(a, b);
  gettimeofday(&t2, NULL);
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec)/1000000.0;
  printf("Time used by minmax1: %f\n", timeuse);

  initial(a, b);
  gettimeofday(&t1, NULL);
  minmax2(a, b);
  gettimeofday(&t2, NULL);
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec)/1000000.0;
  printf("Time used by minmax2: %f\n", timeuse);

  return 0;
}

