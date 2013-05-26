#include <stdlib.h>
#include <stdio.h>

/**
 * Lab: Find a way to crash the following program
 */


void getUserFromHome(char *dest, char *home) {
  char *copy = dest;

  while ( *home != '\0'  ) {
    if ( *home == '/'  ) {
      copy = dest;
      home++;
      continue;
    }
    *copy++ = *home++;
  }
  *copy = '\0';
}

int main ()
{
  char* pHome;
  char pUser[100];
  pHome = getenv ("HOME");
  if (pHome!=NULL) {
    getUserFromHome( pUser, pHome  );
    printf("Extracted user path = %s\n", pUser);
  }

  return 0;
}

