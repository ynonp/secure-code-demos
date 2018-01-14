import nacl.utils
import sys
from nacl.public import PrivateKey, PublicKey, Box

if len(sys.argv) != 5:
    exit("Usage: {} <secret_key> <public_key> <input_file_name> <output_encrypted_file_name>".format(*sys.argv))

(_, skey_file, pkey_file, input_file, output_file) = sys.argv

def chunk_nonce(base, index):
    size = Box.NONCE_SIZE
    return int.to_bytes(int.from_bytes(base, byteorder='big') + index, length=size, byteorder='big')

def read_in_chunks(file_object, chunk_size=16 * 1024):
    """Lazy function (generator) to read a file piece by piece.
    Default chunk size: 16k."""
    index = 0
    while True:
        data = file_object.read(chunk_size)
        if not data:
            break
        yield (data, index)
        index += 1

with open(pkey_file, 'rb') as f:
    pkey_bytes = f.read()

with open(skey_file, 'rb') as f:
    skey_bytes = f.read()

box = Box(PrivateKey(skey_bytes), PublicKey(pkey_bytes))

nonce = nacl.utils.random(Box.NONCE_SIZE)
with open(output_file, 'wb') as fout:
    with open(input_file, 'rb') as fin:
        for chunk, index in read_in_chunks(fin):
            text = box.decrypt(chunk)
            fout.write(text)
