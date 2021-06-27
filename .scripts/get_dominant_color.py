from os.path import expanduser
from re import findall
from PIL import Image
from sys import argv

print(f'#{"".join(map(lambda c: hex(c.histogram().index(max(c.histogram())))[2:].rjust(2, "0"), Image.open(argv[1]).split()))}')
