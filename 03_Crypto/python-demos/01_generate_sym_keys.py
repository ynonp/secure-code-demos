import nacl.secret
import nacl.utils
import nacl.encoding
import nacl.signing
from nacl.public import PrivateKey
import os

key = nacl.utils.random(nacl.secret.SecretBox.KEY_SIZE)
os.makedirs('keys', exist_ok=True)
os.chdir('keys')

with open('symkey.bin', 'wb') as f:
    f.write(key)

auth_key = nacl.utils.random(size=64)
with open('authkey.bin', 'wb') as f:
    f.write(auth_key)

signing_key = nacl.signing.SigningKey.generate()
with open('signkey.bin', 'wb') as f:    
    f.write(bytes(signing_key))

with open('verifykey.bin', 'wb') as f:
    f.write(bytes(signing_key.verify_key))

skbob = PrivateKey.generate()
pkbob = skbob.public_key

skalice = PrivateKey.generate()
pkalice = skalice.public_key

with open('bob.pub', 'wb') as f:
    f.write(bytes(pkbob))

with open('bob.secret', 'wb') as f:
    f.write(bytes(skbob))

with open('alice.pub', 'wb') as f:
    f.write(bytes(pkalice))

with open('alice.secret', 'wb') as f:
    f.write(bytes(skalice))
