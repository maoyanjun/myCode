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
L0 = 5.0  # length of pendulum 1 in m
L = np.zeros(8)
for i in range(8):
    L[i] = L0+d*i
L2 = 5.5  # length of pendulum 1 in m
L3 = 6.0  # length of pendulum 1 in m
L4 = 6.5


# create a time array from 0..100 sampled at 0.05 second steps
dt = 0.05
t = np.arange(0.0, 100, dt)
x = np.zeros((8,len(t)))
y = np.zeros((8,len(t)))

# th1 and th2 are the initial angles (degrees)
# w10 and w20 are the initial angular velocities (degrees per second)
th1 = 3.0

# initial state
th1 = np.radians(th1)

for i in range(8):
    theta1 = th1*cos(np.sqrt(G/L[i])*t[:])
    x[i,:] = L[i]*sin(theta1[:])
    y[i,:] = -L[i]*cos(theta1[:])

#  theta2 = th1*cos(np.sqrt(G/L2)*t[:])
#  x2 = L2*sin(theta2[:])
#  y2 = -L2*cos(theta2[:])
#
#  theta3 = th1*cos(np.sqrt(G/L3)*t[:])
#  x3 = L3*sin(theta3[:])
#  y3 = -L3*cos(theta3[:])
#
#  theta4 = th1*cos(np.sqrt(G/L4)*t[:])
#  x4 = L4*sin(theta4[:])
#  y4 = -L4*cos(theta4[:])
#
fig = plt.figure()
ax = fig.add_subplot(111, autoscale_on=False, xlim=(-2, 2), ylim=(-8, 2))
ax.grid()
line = np.zeros(8,dtype=ax.plot())
for i in range(8):
    line[i], = ax.plot([], [], 'o-', lw=2)
time_template = 'time = %.1fs'
time_text = ax.text(0.05, 0.9, '', transform=ax.transAxes)


def init():
    line.set_data([], [])
    time_text.set_text('')
    return line, time_text


def animate(i):
    for j in range(8):
        thisx[j] = [0, x[j,i]]
        thisy[j] = [0, y[j,i]]

    #  thisx2 = [0, x2[i]]
    #  thisy2 = [0, y2[i]]
#
    #  thisx3 = [0, x3[i]]
    #  thisy3 = [0, y3[i]]
    #  thisx4 = [0, x4[i]]
    #  thisy4 = [0, y4[i]]
#
    line.set_data(thisx, thisy)
    #  line2.set_data(thisx2, thisy2)
    #  line3.set_data(thisx3, thisy3)
    #  line4.set_data(thisx4, thisy4)
    time_text.set_text(time_template % (i*dt))
    return line, time_text

ani = animation.FuncAnimation(fig, animate, np.arange(1, len(y[0,:])),
                              interval=50, blit=True, init_func=init)

# ani.save('double_pendulum.mp4', fps=15)
plt.show()
