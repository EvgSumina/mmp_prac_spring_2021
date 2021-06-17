#!/usr/bin/python3

import sys
import numpy as np

line = sys.stdin.readline().rstrip('\n')
prev_key, value = line.split('\t')
R, S = value.split(':')
R_arr = [float(R)]
S_arr = [float(S)]

for line in sys.stdin:
    line = line.strip()
    key, value = line.split('\t')
    if key != prev_key:
        R_arr = np.array(R_arr)
        S_arr = np.array(S_arr)
        pred = np.sum(R_arr * S_arr) * 5 / (np.sum(S_arr) + 1e-5)
        User_ID, Item_ID = prev_key.split(':')
        print('%s:%s\t%s' % (User_ID, Item_ID, pred))
    R, S = value.split(':')
    R_arr = [float(R)]
    S_arr = [float(S)]

R_arr = np.array(R_arr)
S_arr = np.array(S_arr)
pred = np.sum(R_arr * S_arr) * 5 / (np.sum(S_arr) + 1e-5)
User_ID, Item_ID = prev_key.split(':')
print('%s:%s\t%s' % (User_ID, Item_ID, pred))
