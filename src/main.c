#include "stdio.h"
#include "lib.h"

int main() {
  char *hel = hello();
  fwrite(hel, 1, sizeof hel, stdout);
  return 0;
}

