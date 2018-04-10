#!/usr/bin/python
import re
import os 
from pylab import *
#import matplotlib.pyplot as plt
#from matplotlib.ticker import  MultipleLocator
pathname = os.path.abspath('./Data/Motion')
#sorting the Translation data
fileR = open(os.path.join(pathname,'Translation'), 'r')
a=open(os.path.join(pathname,'splitTranslation'), 'w')
data = fileR.read()
fileR.close()
data = re.split('\n',data)
t=[]
for k in range(len(data)-1):
    line = data[k]
    line = re.split('\(|\)| ',line) 

    t.append(float(line[10]))
b = []
for tmp in t:
    b.append(str(tmp))
    
for ip in b:
    a.write(ip)
    a.write("\n")
a.close()
#sorting the Velocity data
fileR = open(os.path.join(pathname,'Velocity'), 'r')
a=open(os.path.join(pathname,'splitVelocity'), 'w')
data = fileR.read()
fileR.close()
data = re.split('\n',data)
t=[]
for k in range(len(data)-1):
    line = data[k]
    line = re.split('\(|\)| ',line) 
   
    t.append(float(line[9]))
b = []
for tmp in t:
    b.append(str(tmp))
    
for ip in b:
    a.write(ip)
    a.write("\n")
a.close()

#sorting the Time data
fileR = open(os.path.join(pathname,'Time'), 'r')
a=open(os.path.join(pathname,'splitTime'), 'w')
data = fileR.read()
fileR.close()
data = re.split('\n',data)
del data[0]
t=[]
for k in range(len(data)-1):
    line = data[k]
    line = line.split(' ') 
   
    t.append(float(line[2]))
b = []
for tmp in t:
    b.append(str(tmp))
    
for ip in b:
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
    
fileR = open(os.path.join(pathname,'splitVelocity'), 'r')
vel = fileR.read()
fileR.close()
vel = vel.split('\n')
vel.pop()
Vel = []
for tmp2 in vel:
    Vel.append(float(tmp2))
    
fileR = open(os.path.join(pathname,'splitTranslation'), 'r')
dis = fileR.read()
fileR.close()
dis = dis.split('\n')
dis.pop()
Dis = []
for tmp3 in dis:
    Dis.append(float(tmp3))


#plot
#xmajorLocator = MultipleLocator(5)
#xminorLocator = MultipleLocator(1) 
subplot(2,1,1)
plot(time,Dis)
xlabel('t (s)')    
ylabel('$h + \eta$ (m)')
title('displacement')

subplot(2,1,2)
plot(time,Vel)
ylabel('velocity (m/s)')
title('velocity')
savefig('./Data/Motion/displacementAndvelocity')
show()
