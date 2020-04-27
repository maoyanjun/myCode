#!/usr/bin/python
import math
h=float(raw_input('please input water depth h:'))
waveNumber=float(raw_input('please input wave number:'))
T=2*3.1415926/math.sqrt((9.8*waveNumber*math.tanh(waveNumber*h)))
print "wave Period is:",T
