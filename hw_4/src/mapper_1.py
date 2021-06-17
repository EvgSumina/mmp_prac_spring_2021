#!/usr/bin/python3

import sys

sys.stdin.readline()

for line in sys.stdin:
    try:
        line = line.strip()
        words = line.split(',')
        print('%s\t%s:%s' % (words[0], words[1], words[2]))
    except:
        pass
