#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Lab:
 *
 * 1. Find the inputs to make the following program crash
 *
 * (Bonus) Perform a return-to-libc attack to get the
 * program exit normally without printing anything
 */

int main( int argc, char **argv )
{
  int i = 0;
  char buf[32] = "";

  if ( argc < 3 )
  {
    printf("Usage: %s <name> <number>\n", argv[0]);
    exit(1);
  }

  int count = atoi(argv[2]);

  if ( strlen(argv[1]) < sizeof(buf) )
  {
    for ( i=0; i < count; i++ )
    {
      strcat( buf, argv[1] );
    }
  }

  printf( "%s\n", buf );
}
