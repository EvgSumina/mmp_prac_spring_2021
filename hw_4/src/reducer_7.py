#!/usr/bin/python3

import sys
import numpy as np


prev_user = None

for line in sys.stdin:
    User_ID, value = line.strip().split('\t')
    name, R = value.split('@')
    if User_ID != prev_user:
        if prev_user != None:
            print('%s' % (prev_user), end='@')
            R_arr = np.sort(R_arr)
            names = np.array(names)
            names = names[np.argsort(R_arr)]
            for i in range(len(R_arr) - 1, -1, -1):
                print('%s#%s' % (R_arr[i], names[i]), end='')
                if i > 0:
                    print('@', end='')
            print('')
        prev_user = User_ID
        names = []
        R_arr = []
    names.append(name)
    R_arr.append(float(R))

print('%s' % (prev_user), end='@')
R_arr = np.sort(R_arr)
names = np.array(names)
names = names[np.argsort(R_arr)]
for i in range(len(R_arr) - 1, -1, -1):
    print('%s#%s' % (R_arr[i], names[i]), end='')
    if i > 0:
        print('@', end='')
print('')
