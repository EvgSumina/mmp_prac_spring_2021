#!/usr/bin/python3

import sys
import numpy as np


prev_item = None

for line in sys.stdin:
    key, value = line.strip().split('\t')
    Item_ID, tag = key.split(':')
    if Item_ID != prev_item:
        if prev_item != None:
            for i, user in enumerate(User_arr):
                print('%s\t%s@%s' % (user, value, R_arr[i]))
        prev_item = Item_ID
        User_arr = []
        R_arr = []
    if tag == 'B':
        User_ID, R = value.split(':')[0]
        User_arr.append(User_ID)
        R_arr.append(R)

for i, user in enumerate(User_arr):
    print('%s\t%s@%s' % (user, value, R_arr[i]))
