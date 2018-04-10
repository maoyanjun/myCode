#!/usr/bin/python
import re
import os 
from pylab import *

depth = float(raw_input("input the Reference water depth:"))
pathname = os.path.abspath('./Data/Motion')
#sorting the Translation data
fileR = open(os.path.join(pathname,'splitTranslation'), 'r')
a=open(os.path.join(pathname,'dealTranslation'), 'w')
data = fileR.read()
fileR.close()
data = re.split('\n',data)
t=[]
for k in range(len(data)-1):
    t.append(str(float(data[k])-depth))
   # print t
#b = []
#for tmp in t:
#    b.append(str(tmp))
    
for ip in t:
    a.write(ip)
    a.write("\n")
a.close()


#ploting translation and velocity
fileR = open(os.path.join(pathname,'splitTime'), 'r')
time1 = fileR.read()
fileR.close()
time1 = time1.split('\n')
time1.pop()
time = []
for tmp1 in time1:
    time.append(float(tmp1))
    
fileR = open(os.path.join(pathname,'dealTranslation'), 'r')
dis0 = fileR.read()
fileR.close()
dis0 = dis0.split('\n')
dis0.pop()
Dis0 = []
for tmp4 in dis0:
    Dis0.append(float(tmp4))
    
    
plot(time,Dis0)
xlabel('t (s)')    
ylabel('$h + \eta$ (m)')
title('displacement0')
