import nacl.secret
import nacl.utils
import sys

if len(sys.argv) != 4:
    exit("Usage: {} <key> <input_file_name> <output_encrypted_file_name>".format(*sys.argv))

(_, keyfile, input_file, output_file) = sys.argv

def chunk_nonce(base, index):
    size = nacl.secret.SecretBox.NONCE_SIZE
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

with open(keyfile, 'rb') as f:
    key = f.read()

box = nacl.secret.SecretBox(key)

nonce = nacl.utils.random(nacl.secret.SecretBox.NONCE_SIZE)
with open(output_file, 'wb') as fout:
    with open(input_file, 'rb') as fin:
        for chunk, index in read_in_chunks(fin, chunk_size=16*1024 - 40):
            enc = box.encrypt(chunk, chunk_nonce(nonce, index))
            fout.write(enc)
