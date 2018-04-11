#!/usr/bin/python

import numpy as np
import math
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
T[0]
print(T)
L=[0]*N
k=[0]*N
w=[0]*N
QTF=[0]*N
H = 0.1
#T = 3.0
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
print(T[0])
for i in range(0,N):
    L[i]=dispersion(T[i],h)
#    L0 = 9.81*T[i]**2/(2.*np.pi)
#    L[i] = L0
#    print (i)
#    print(L[i])
#    for i in range(0,100):
#        print(i)
#        print(L[i])
#        print(L0)
#        print(h)
#        Lnew = L0 * np.tanh(2.*np.pi/L[i]*h)
#        print(Lnew)
#        if(abs(Lnew-L[i])<0.001):
#            L[i] = Lnew
#            break
#        L[i] = Lnew
    k[i] = 2.*np.pi/L[i]
    w[i] = 2.*np.pi/T[i]
    QTF[i]=2*(math.cosh(2*k[i]*h)-1)/(2*k[i]*h+math.sinh(2*k[i]*h))
print(L)
print(k)
print(w)
print(QTF)
print(a)
times = np.linspace(t0, tEnd, round((tEnd-t0)/dt)+1)
coords = np.linspace(bLims[0], bLims[1], nPaddles+1)
coords = coords[:-1] + np.diff(coords)/2.
# Export
fid = open('wavemakerMovement.txt', 'w')

fid.write('wavemakerType   Piston;\n')
fid.write('tSmooth         1.5;\n')
fid.write('genAbs          0;\n\n')

fid.write('timeSeries {0}(\n'.format( len(times) ))
for t in times:
    fid.write('{0}\n'.format(t))
fid.write(');\n\n'.format( len(times) ))

fid.write('paddlePosition {0}(\n'.format( nPaddles ))
for i in range(0, nPaddles):
    fid.write('{0}(\n'.format( len(times) ))
    for t in times:
        for i in range(0,N):
            x+=a[i]/QTF[i]*math.sin(k[i]*(-xb)-w[i]*(t-tb))
        print(x)
        fid.write('{0}\n'.format(x))       
    fid.write(')\n')
fid.write(');\n\n')
eta=0
fid.write('paddleEta {0}(\n'.format( nPaddles ))
for i in range(0, nPaddles):
    fid.write('{0}(\n'.format( len(times) ))
    for t in times:
        for i in range(0,N):
            eta = a[i]*np.cos(k[i]*(-xb)-w[i]*(t-tb))
        fid.write('{0}\n'.format(x))       
    fid.write(')\n')
fid.write(');\n\n')

fid.close()
