#!/usr/bin/python3

import sys
import numpy as np


line = sys.stdin.readline().rstrip('\n')
key, value = line.split('\t')
prev_User_ID, Item_ID = key.split(':')
item_arr = [Item_ID]
rating_arr = [float(value)]

for line in sys.stdin:
    line = line.strip()
    key, value = line.split('\t')
    User_ID, Item_ID = key.split(':')
    if User_ID != prev_User_ID:
        item_arr = np.array(item_arr)
        rating_arr = np.array(rating_arr)
        idc = np.argsort(rating_arr)[::-1][:100]
        item_arr = item_arr[idc]
        rating_arr = rating_arr[idc]
        for i, item in enumerate(item_arr):
            print('%s\t%s:%s' % (item, prev_User_ID, rating_arr[i]))
        prev_User_ID = User_ID
        item_arr = [Item_ID]
        rating_arr = [float(value)]
    if len(item_arr) != 0 and item_arr[-1] == item:
        item_arr.pop(-1)
        rating_arr.pop(-1)
    else:
        item_arr.append(Item_ID)
        rating_arr.append(float(value))

item_arr = np.array(item_arr)
rating_arr = np.array(rating_arr)
idc = np.argsort(rating_arr)[::-1][:100]
item_arr = item_arr[idc]
rating_arr = rating_arr[idc]
for i, item in enumerate(item_arr):
    print('%s\t%s:%s' % (item, prev_User_ID, rating_arr[i]))
