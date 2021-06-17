#!/usr/bin/python3

import sys

line = sys.stdin.readline().rstrip('\n')
prev_key, value = line.split('\t')
tag, item_1, item_2 = value.split(':')
Input_A = []
Input_B = []
if tag == 'A':
    Input_A.append((item_1, item_2))
else:
    Input_B.append((item_1, item_2))

for line in sys.stdin:
    line = line.strip()
    key, value = line.split('\t')
    tag, item_1, item_2 = value.split(':')
    if key != prev_key:
        for User_ID, R in Input_A:
            for Item_ID, S in Input_B:
                print('%s:%s\t%s:%s' % (User_ID, Item_ID, R, S))
        prev_key = key
        Input_A = []
        Input_B = []
    if tag == 'A':
        Input_A.append((item_1, item_2))
    else:
        Input_B.append((item_1, item_2))

for User_ID, R in Input_A:
    for Item_ID, S in Input_B:
        print('%s:%s\t%s:%s' % (User_ID, Item_ID, R, S))
