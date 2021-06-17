#!/usr/bin/python3

import sys


for line in sys.stdin:
    line = line.strip()
    if len(line.split(',')) == 1:
        key, value = line.split('\t')
        print('%s:B\t%s' % (key, value))
    else:
        try:
            key, value = line.split(',')
            if len(value.split('"')) > 1:
                value = line.split('"')[1]
            print('%s:A\t%s' % (key, value))
        except:
            pass
