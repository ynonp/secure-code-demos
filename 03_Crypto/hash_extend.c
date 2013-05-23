#include <stdio.h>
#include <openssl/md5.h>

int main(int argc, const char *argv[])
{
  int i;
  unsigned char buffer[MD5_DIGEST_LENGTH];
  MD5_CTX c;

  MD5_Init(&c);
  MD5_Update(&c, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 64);

  c.A = htonl(0x6036708e); /* <-- Current hash */
  c.B = htonl(0xba0d11f6);
  c.C = htonl(0xef52ad44);
  c.D = htonl(0xe8b74d5b);

  MD5_Update(&c, "wow", 3); /* Appended Data */
  MD5_Final(buffer, &c);
  for (i = 0; i < 16; i++) {
    printf("%02x", buffer[i]);
  }
  printf("\n");
  return 0;
}
