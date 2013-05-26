#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  unsigned short total;

  total = strlen(argv[1]) + strlen(argv[2]);
  char *buf = (char *)malloc(total);

  strcpy(buf, argv[1]);
  strcat(buf, argv[2]);
}

