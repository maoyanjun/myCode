#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
===========================
The double pendulum problem
===========================

This animation illustrates the double pendulum problem.
"""

# Double pendulum formula translated from the C code at
# http://www.physics.usyd.edu.au/~wheat/dpend_html/solve_dpend.c

from numpy import sin, cos
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as integrate
import matplotlib.animation as animation

G = 9.8  # acceleration due to gravity, in m/s^2
d = 0.2
L1 = 2.0  # length of pendulum 1 in m
L2 = L1+d*1
L3 = L1+d*2
L4 = L1+d*3
L5 = L1+d*4
L6 = L1+d*5
L7 = L1+d*6
L8 = L1+d*7
L9 = L1+d*8
L10 = L1+d*9
L11 = L1+d*10
L12 = L1+d*11
L13 = L1+d*12
L14 = L1+d*13
L15 = L1+d*14

# create a time array from 0..100 sampled at 0.05 second steps
dt = 0.1
t = np.arange(0.0, 50, dt)

# th1 and th2 are the initial angles (degrees)
# w10 and w20 are the initial angular velocities (degrees per second)
th1 = 3.0

# initial state
th1 = np.radians(th1)

theta1 = th1*cos(np.sqrt(G/L1)*t[:])
x1 = L1*sin(theta1[:])
y1 = -L1*cos(theta1[:])

theta2 = th1*cos(np.sqrt(G/L2)*t[:])
x2 = L2*sin(theta2[:])
y2 = -L2*cos(theta2[:])

theta3 = th1*cos(np.sqrt(G/L3)*t[:])
x3 = L3*sin(theta3[:])
y3 = -L3*cos(theta3[:])

theta4 = th1*cos(np.sqrt(G/L4)*t[:])
x4 = L4*sin(theta4[:])
y4 = -L4*cos(theta4[:])

theta5 = th1*cos(np.sqrt(G/L5)*t[:])
x5 = L5*sin(theta5[:])
y5 = -L5*cos(theta5[:])

theta6 = th1*cos(np.sqrt(G/L6)*t[:])
x6 = L6*sin(theta6[:])
y6 = -L6*cos(theta6[:])

theta7 = th1*cos(np.sqrt(G/L7)*t[:])
x7 = L7*sin(theta7[:])
y7 = -L7*cos(theta7[:])

theta8 = th1*cos(np.sqrt(G/L8)*t[:])
x8 = L8*sin(theta8[:])
y8 = -L8*cos(theta8[:])

theta9 = th1*cos(np.sqrt(G/L9)*t[:])
x9 = L9*sin(theta9[:])
y9 = -L9*cos(theta9[:])

theta10 = th1*cos(np.sqrt(G/L10)*t[:])
x10= L10*sin(theta10[:])
y10= -L10*cos(theta10[:])

theta11 = th1*cos(np.sqrt(G/L11)*t[:])
x11 = L11*sin(theta11[:])
y11 = -L11*cos(theta11[:])

theta12 = th1*cos(np.sqrt(G/L12)*t[:])
x12 = L12*sin(theta12[:])
y12 = -L12*cos(theta12[:])

theta13 = th1*cos(np.sqrt(G/L13)*t[:])
x13 = L13*sin(theta13[:])
y13 = -L13*cos(theta13[:])

theta14 = th1*cos(np.sqrt(G/L14)*t[:])
x14 = L14*sin(theta14[:])
y14 = -L14*cos(theta14[:])

theta15 = th1*cos(np.sqrt(G/L15)*t[:])
x15 = L15*sin(theta15[:])
y15 = -L15*cos(theta15[:])

#
fig = plt.figure()
ax = fig.add_subplot(111, autoscale_on=False, xlim=(-2, 2), ylim=(-8, 2))
ax.grid()
line1, = ax.plot([], [], 'o-', lw=2)
line2, = ax.plot([], [], 'o-', lw=2)
line3, = ax.plot([], [], 'o-', lw=2)
line4, = ax.plot([], [], 'o-', lw=2)
line5, = ax.plot([], [], 'o-', lw=2)
line6, = ax.plot([], [], 'o-', lw=2)
line7, = ax.plot([], [], 'o-', lw=2)
line8, = ax.plot([], [], 'o-', lw=2)
line9, = ax.plot([], [], 'o-', lw=2)
line10, = ax.plot([], [], 'o-', lw=2)
line11, = ax.plot([], [], 'o-', lw=2)
line12, = ax.plot([], [], 'o-', lw=2)
line13, = ax.plot([], [], 'o-', lw=2)
line14, = ax.plot([], [], 'o-', lw=2)
line15, = ax.plot([], [], 'o-', lw=2)
time_template = 'time = %.1fs'
time_text = ax.text(0.05, 0.9, '', transform=ax.transAxes)


def init():
    line1.set_data([], [])
    line2.set_data([], [])
    line3.set_data([], [])
    line4.set_data([], [])
    line5.set_data([], [])
    line6.set_data([], [])
    line7.set_data([], [])
    line8.set_data([], [])
    line9.set_data([], [])
    line10.set_data([], [])
    line11.set_data([], [])
    line12.set_data([], [])
    line13.set_data([], [])
    line14.set_data([], [])
    line15.set_data([], [])
    time_text.set_text('')
    return line1,line2,line3,line4,line5,line6,line7,line8,line9,line10,line11,line12,line13,line14,line15, time_text


def animate(i):
    thisx1 = [0, x1[i]]
    thisy1 = [0, y1[i]]
    thisx2 = [0, x2[i]]
    thisy2 = [0, y2[i]]
    thisx3 = [0, x3[i]]
    thisy3 = [0, y3[i]]
    thisx4 = [0, x4[i]]
    thisy4 = [0, y4[i]]
    thisx5 = [0, x5[i]]
    thisy5 = [0, y5[i]]
    thisx6 = [0, x6[i]]
    thisy6 = [0, y6[i]]
    thisx7 = [0, x7[i]]
    thisy7 = [0, y7[i]]
    thisx8 = [0, x8[i]]
    thisy8 = [0, y8[i]]
    thisx9 = [0, x9[i]]
    thisy9 = [0, y9[i]]
    thisx10 = [0, x10[i]]
    thisy10 = [0, y10[i]]
    thisx11 = [0, x11[i]]
    thisy11 = [0, y11[i]]
    thisx12 = [0, x12[i]]
    thisy12 = [0, y12[i]]
    thisx13 = [0, x13[i]]
    thisy13 = [0, y13[i]]
    thisx14 = [0, x14[i]]
    thisy14 = [0, y14[i]]
    thisx15 = [0, x15[i]]
    thisy15 = [0, y15[i]]
#
    line1.set_data(thisx1, thisy1)
    line2.set_data(thisx2, thisy2)
    line3.set_data(thisx3, thisy3)
    line4.set_data(thisx4, thisy4)
    line5.set_data(thisx5, thisy5)
    line6.set_data(thisx6, thisy6)
    line7.set_data(thisx7, thisy7)
    line8.set_data(thisx8, thisy8)
    line9.set_data(thisx9, thisy9)
    line10.set_data(thisx10, thisy10)
    line11.set_data(thisx11, thisy11)
    line12.set_data(thisx12, thisy12)
    line13.set_data(thisx13, thisy13)
    line14.set_data(thisx14, thisy14)
    line15.set_data(thisx15, thisy15)
    time_text.set_text(time_template % (i*dt))
    return line1,line2,line3,line4,line5,line6,line7,line8,line9,line10,line11,line12,line13,line14,line15, time_text

ani = animation.FuncAnimation(fig, animate, np.arange(1, len(y1)),
                              interval=200, blit=True, init_func=init)

ani.save('double_pendulum.mp4', fps=15)
#  plt.show()
