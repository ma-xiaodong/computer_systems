#include <stdio.h>
#include <sys/time.h>

#define LENGTH 4096
#define OP     *
#define IDENT  1
#define TYPE   double

TYPE combine5(TYPE *data) {
  struct timeval t1,t2;
  double timeuse;

  long idx, limit;
  TYPE acc = IDENT;

  limit = LENGTH - 1;
  gettimeofday(&t1, NULL);
#ifdef UNROLL
  for (idx = 0; idx < limit; idx += 8) {
    acc = (acc OP data[idx]) OP data[idx + 1];
    acc = (acc OP data[idx + 2]) OP data[idx + 3];
    acc = (acc OP data[idx + 4]) OP data[idx + 5];
    acc = (acc OP data[idx + 6]) OP data[idx + 7];
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
  timeuse = t2.tv_sec - t1.tv_sec + (t2.tv_usec - t1.tv_usec)/1000000.0;
  printf("Use Time: %f\n", timeuse);
  return acc;
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
  return 0;
}
