#include <stdio.h>
#include <string.h>

int check_password()
{
  char password[132];
  printf("stack at: 0x%p\n", password);

  gets( password );

  return ! strncmp(password, "letmein", 16);
}

int main( int argc, char **argv )
{
  printf("Hello. What's the password ?\n");

  int master = check_password();

  if ( master )
  {
    printf("Welcome, master\n");
  }
  else
  {
    printf("INTRUDER ALERT\n");
  }
}

