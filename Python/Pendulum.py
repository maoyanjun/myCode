#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
import math

l0=5
d=1
alpha = 3
theta = np.zeros(8)
t = np.linspace(0,100,10000)
S = np.zeros((8,10000))
l = np.zeros(8)

for i in range(8):
    l[i] = l0+d*i
    for j in range(len(t)):
        theta[i] = alpha*math.cos(math.sqrt((9.8/l[i])*t[j]))
        S[i,j] =l[i]*math.sin(theta[i])
print(S)
