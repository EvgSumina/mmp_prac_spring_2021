#!/usr/bin/python3

import sys
import numpy as np

line = sys.stdin.readline().rstrip('\n')
UserID, values = line.split('\t')
item, rating = values.split(':')
ItemID = [item]
Rating = [float(rating)]

for line in sys.stdin:
    line = line.strip()
    key, values = line.split('\t')
    if key == UserID:
        item, rating = values.split(':')
        ItemID.append(item)
        Rating.append(float(rating))
    else:
        ave = np.mean(Rating)
        Rating = Rating - ave
        length = len(ItemID)
        for i in range(length):
            DR_i = str(Rating[i])
            Item_i = ItemID[i]
            for j in range(i + 1, length):
                print('%s:%s\t%s:%s' % (Item_i, ItemID[j], DR_i, str(Rating[j])))
        UserID = key
        item, rating = values.split(':')
        ItemID = [item]
        Rating = [float(rating)]
ave = np.mean(Rating)
Rating = Rating - ave
length = len(ItemID)
for i in range(length):
    DR_i = str(Rating[i])
    Item_i = ItemID[i]
    for j in range(i + 1, length):
        print('%s:%s\t%s:%s' % (Item_i, ItemID[j], DR_i, str(Rating[j])))
