#!/usr/bin/python3

import sys


for line in sys.stdin:
    line = line.strip()
    if line.split('\t') > 1:
        key, value = line.split('\t')
        key_1, key_2 = key.strip().split(':')
        print('%s\tB:%s:%s' % (key_1, key_2, value))
        print('%s\t%s' % (key_2, key_1, value))
    else:
        try:
            UserID, key, R = line.split(',')
            print('%s\tA:%s:%s' % (key, UserID, R))
        except:
            pass
