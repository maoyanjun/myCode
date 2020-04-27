import re
import os 
from pylab import *

startTime = float(raw_input("input the start Time:"))
endTime=float(raw_input("input the end Time:"))
dampingCoeff=float(raw_input("input the damping coeff:"))
S=0
pathname = os.path.abspath('./Data/Motion')
#sorting the Translation data
fileTime=open(os.path.join(pathname,'splitTime'), 'r')
fileR = open(os.path.join(pathname,'splitVelocity'), 'r')
a=open(os.path.join(pathname,'dealTranslation'), 'w')
Time=fileTime.read()
fileTime.close()
Time = re.split('\n',Time)
Vel = fileR.read()
fileR.close()
Vel = re.split('\n',Vel)
for i in range(len(Time)-1):
    Time[i]=float(Time[i])
    Vel[i]=float(Vel[i])
for i in range(len(Time)-1):
    if startTime <=Time[i] and endTime >= Time[i]:
        S+=dampingCoeff*(Time[i+1]-Time[i])/6*(abs(Vel[i])+4*(abs(Vel[i])+abs(Vel[i+1]))/2+abs(Vel[i+1]))
        print Time[i]
print 'the intergrated Value is ', S
