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
H = 0.1
T = 3.0
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
L = dispersion(T, h)
k = 2.*np.pi/L
w = 2.*np.pi/T

times = np.linspace(t0, tEnd, round((tEnd-t0)/dt)+1)
coords = np.linspace(bLims[0], bLims[1], nPaddles+1)
coords = coords[:-1] + np.diff(coords)/2.

HoS = 4. * np.sinh(k*h)**2. / (np.sinh(2.*k*h) + 2.*k*h)
S = H/HoS
maxdisplacement=np.sqrt(16*H/3/h)*h
waveVel=np.sqrt(9.81*(h+H))
Tmax = 2/waveVel*np.sqrt(4*math.pow(h,3)/3/H)*(3.8+H/h);
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
        xj =0
        x = np.sqrt(4*H/3/h)*h*(1 + np.tanh(np.sqrt(3*H/4/math.pow(h,3))*(waveVel*(t-Tmax/2)-(xj-maxdisplacement/2))))
        while abs(x - xj) > 0.000001:
		        xj=x
		        x = np.sqrt(4*H/3/h)*h*(1 + np.tanh(np.sqrt(3*H/4/math.pow(h,3))*(waveVel*(t-Tmax/2)-(xj-maxdisplacement/2))))
        if x <= maxdisplacement:
            fid.write('{0}\n'.format(x))
        else:
        	  fid.write('{0}\n'.format(maxdisplacement))       
    fid.write(')\n')
fid.write(');\n\n')

#fid.write('paddleEta {0}(\n'.format( nPaddles ))
#for i in range(0, nPaddles):
#    fid.write('{0}(\n'.format( len(times) ))
#    for t in times:
#        x = H/2. * np.cos(-w*t + phase0 + 2.*np.pi*coords[i]/L*np.sin(direction*np.pi/180.) )
#        fid.write('{0}\n'.format(x))       
#    fid.write(')\n')
#fid.write(');\n\n')
#
#fid.close()
