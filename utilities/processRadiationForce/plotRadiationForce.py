#!/usr/bin/python
import re
import os 
from pylab import *

pathname = os.path.abspath('./Data')
readPath = os.path.join(pathname,'RadiationForce')
a = os.listdir(readPath)

fileR = open(os.path.join(readPath,'average_RadiationForce'), 'r')
data = fileR.read()
fileR.close()
data = data.split('\n')
x = []
y = []
for i in range(len(data)-1):
    line = data[i]
    line = line.split(' ') 
    x.append(float(line[0]))
    y.append(float(line[1]))

plot(x,y,lineWidth=4.0)
xlabel('probe position(m)',fontsize=18)    
ylabel('Radiation force',fontsize=18)
xticks(fontsize=15)
yticks(fontsize=15)
title('average radiation force')
savefig('./Data/RadiationForce')
show()
