#!/usr/bin/python3

import sys
import numpy as np


line = sys.stdin.readline().rstrip('\n')
key, value = line.split('\t')
Item_I, Item_J = key.split(':')
DR_i, DR_j = value.split(':')
DRA = np.array(float(DR_i))
DRB = np.array(float(DR_j))

for line in sys.stdin:
    line = line.strip()
    key, value = line.split('\t')
    Item_i, Item_j = key.split(':')
    DR_i, DR_j = value.split(':')
    if Item_i == Item_I and Item_j == Item_J:
        DRA = np.append(DRA, float(DR_i))
        DRB = np.append(DRB, float(DR_j))
    else:
        nom = np.dot(DRA, DRB)
        denom = np.linalg.norm(DRA + 1e-5) * np.linalg.norm(DRB + 1e-5)
        nom /= denom
        if nom < 0:
            nom = 0
        print("%s:%s\t%s" % (Item_I, Item_J, nom))
        Item_I, Item_J = Item_i, Item_j
        DRA = np.array(float(DR_i))
        DRB = np.array(float(DR_j))
nom = np.dot(DRA, DRB)
denom = np.linalg.norm(DRA + 1e-5) * np.linalg.norm(DRB + 1e-5)
nom /= denom
if nom < 0:
    nom = 0
print("%s:%s\t%s" % (Item_I, Item_J, nom))
