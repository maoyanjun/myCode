#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    Date: 2019-01-04
    Author: Maoyanjun
    Email: maoyanjun_dut@foxmail.com
    HomePage: http://maoyanjun.top
    LastChange: 2019-01-04 11:08:06
    Discription:  run in the case path. generate the theory focus wave surface elevation and store it at Data/ to plot the figure.
    History: fixed eta =0 for the integration
"""

import numpy as np
import math
import os
def dispersion(T, h):    
    L0 = 9.81*T**2/(2.*np.pi)
    L = L0
    for i in range(0,100):
        Lnew = L0 * np.tanh(2.*np.pi/L*h)
        if(abs(Lnew-L)<0.001):
            L = Lnew
            break
        L = Lnew
    return L

## Piston wavemaker data ##
A=0.022
N=29
a=[A/N]*N
Ts=0.8
Tn=1.2
T=np.arange(Ts,Tn,(Tn-Ts)/N)
x=0
xb=5.88
tb=16.0
L=[0]*N
k=[0]*N
w=[0]*N
h = 0.4
phase0 = 0.
direction = 0.

nPaddles = 1
bLims = [0., 0.]

t0 = 0.
tEnd = 30.
dt = 0.05
########################

# Calculations
for i in range(0,N):
    L[i]=dispersion(T[i],h)
    k[i] = 2.*np.pi/L[i]
    w[i] = 2.*np.pi/T[i]
#print("L")
#print(L)
#print("k")
#print(k)
#print("w")
#print(w)
#print("a")
#print(a)
times = np.linspace(t0, tEnd, round((tEnd-t0)/dt)+1)
coords = np.linspace(bLims[0], bLims[1], nPaddles+1)
coords = coords[:-1] + np.diff(coords)/2.
# Export
pathname = os.path.abspath('./Data')
fid = open(os.path.join(pathname,'ThoryFocusWaveSurface.txt'), 'w')

for t in times:
    eta=0
    for i in range(0,N):
        eta += a[i]*np.cos(k[i]*(xb-xb)-w[i]*(t-tb))
    fid.write('{0}'.format(t) + ' ' + '{0}\n'.format(eta))
fid.close()

