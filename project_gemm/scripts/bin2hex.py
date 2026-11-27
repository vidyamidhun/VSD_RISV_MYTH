import struct, sys
data = open(sys.argv[1], 'rb').read()
with open(sys.argv[2], 'w') as f:
    for (word,) in struct.iter_unpack('<I', data):
        f.write('%08x\n' % word)
