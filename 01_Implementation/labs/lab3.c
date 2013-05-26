#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Lab:
 *
 * 1. Crash the follwing program
 * 2. Explain why input validation didn't work
 */

int main() {
  char path[40];
  char buf[40];
  char prefix[] = "http://";

  printf("Enter address: ");
  fgets(path, 40, stdin);
  strtok(path, "\n");

  strcpy( buf, prefix  );
  strncat(buf, path, sizeof(buf));

  printf("Prefixed = %s\n", buf);
}

