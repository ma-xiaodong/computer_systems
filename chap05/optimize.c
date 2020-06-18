#include <stdio.h>
#include <sys/time.h>

#define LENGTH 4096
#define OP *
#define IDENT 1
#define TYPE float

struct timeval t1, t2;
double timeuse;

TYPE combine5(TYPE *data) {
  long idx, limit;
  TYPE acc = IDENT;

  limit = LENGTH - 1;
  gettimeofday(&t1, NULL);
#ifdef UNROLL
  for (idx = 0; idx < limit; idx += 2) {
    acc = (acc OP data[idx])OP data[idx + 1];
  }
  for (; idx < LENGTH; idx++) {
    acc = acc OP data[idx];
  }
#else
  for (idx = 0; idx < limit; idx++) {
    acc = acc OP data[idx];
  }
#endif
  gettimeofday(&t2, NULL);
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec) / 1000000.0;
  printf("combine5, use Time: %f\n", timeuse);
  return acc;
}

TYPE combine6(TYPE *data) {
  long idx, limit;
  TYPE acc0 = IDENT;
  TYPE acc1 = IDENT;

  limit = LENGTH - 1;
  gettimeofday(&t1, NULL);
  for (idx = 0; idx < limit; idx += 2) {
    acc0 = acc0 OP data[idx];
    acc1 = acc1 OP data[idx + 1];
  }
  for (; idx < LENGTH; idx++) {
    acc0 = acc0 OP data[idx];
  }
  gettimeofday(&t2, NULL);
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec) / 1000000.0;
  printf("combine6, use Time: %f\n", timeuse);
  return acc0 OP acc1;
}

int main(int argc, char *argv) {
  TYPE data[LENGTH], dest;
  long idx;

  for (idx = 0; idx < LENGTH; idx++) {
    switch (idx % 3) {
    case 0:
      data[idx] = 1 / 2.0;
      break;
    case 1:
      data[idx] = 1;
      break;
    case 2:
      data[idx] = 2.0;
      break;
    default:
      data[idx] = 1;
      break;
    }
  }

  dest = combine5(data);
  printf("Result: %f\n", dest);
  dest = combine6(data);
  printf("Result: %f\n", dest);

  return 0;
}
