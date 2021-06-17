#!/usr/bin/python3

import sys


for line in sys.stdin:
    line = line.strip()
    if len(line.split(',')) == 1:
        print(line)
    else:
        try:
            User_ID, Item_ID, R = line.split(',')
            print('%s:%s\t%s' % (User_ID, Item_ID, R))
        except:
            pass
