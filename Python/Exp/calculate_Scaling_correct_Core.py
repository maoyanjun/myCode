#!/usr/bin/python
import math

P = float(0.38)
nvp = float(0.0000010565)
Hi_p = float(3.9)
D_p = float(0.29)
DelatL = float(23.66)
h_p = float(18.6)
T_p = float(18)
L_p = float(181.137)
g=float(9.8)

P_m = float(0.38)
nv_m = float(0.000001365)
Hi_m = float(0.164)
D_m = float(0.0116)
DelatL_m = float(0.9464)
h_m = float(0.344)
T_m= float(4)
L_m = float(7.24548)

Gamma_p = math.pow(P,-4)/10.6*(L_p/D_p)*math.pow((g*h_p*(T_p**2/L_p**2)),float(4)/float(3))
print "Gamma_p= ", Gamma_p

Hi_Ht_p=1+Gamma_p*(Hi_p/(2*h_p))*(DelatL/L_p)
print "Hi_Ht_p= ", Hi_Ht_p 

Rn=(P_m*Hi_m*L_m*D_m)/(2*nv_m*h_m*T_m)
print "Rn= ", Rn

Hi_Ht_m = Hi_Ht_p

Gamma_m = (math.pow(Hi_Ht_m,float(2)/float(3))-1)/(math.pow((Hi_m/(2*h_m)),float(2)/float(3))*(DelatL_m/L_m))
print "Gamma_m= ", Gamma_m
D_m = math.pow((P_m**(-4)/1.52*((nv_m*T_m/L_m)**(1.0/3))*(L_m)*(math.pow(g*h_m*T_m**2/L_m**2,4.0/3.0)))/Gamma_m,3.0/4.0)

print "D_m= ", D_m

K = 25/(D_p/D_m)
print "K= ", K
K1=1.5
K_average= (K1+K)/2
print "K_average= ", K_average
