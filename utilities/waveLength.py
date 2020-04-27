#/usr/bin/python
import math
import sys
#  h=float(input('please input water depth h:'))
#  T=float(input('please input wave proid T:'))
h =10
T =5
b=(9.8*(T**2))/(2*math.pi)
a=b
L=b*math.tanh(2*math.pi/b*h)
i=1
while i<1000:
    if (L-a)**2<0.000004:
       break
    else:
        a=L
        L=b*math.tanh(2*math.pi/L*h)
    i=i+1
wavenumber=2*math.pi/L
print (L)
print (wavenumber)
#input("Press ENTER finish the program")
