#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   PythonThink.py
@Time    :   2020/04/01 19:07:48
@Author  :   Mao Yanjun 
@Version :   1.0
@Contact :   maoyanjun_dut@foxmail.com
@License :   (C)Copyright 1949-2020, DLUT
@Desc    :   None
'''

import turtle
import math
def draw_square(t,length):
    for i in range(4):
        t.fd(length)
        t.lt(90)
def draw_polygon(t,length,n):
    angle = 360.0 / n
    for i in range(n):
        t.fd(length)
        t.lt(angle)
def draw_circle(t,r):
    circumference= 2*math.pi*r
    n=int(circumference / 3) + 1
    length = circumference / n
    draw_polygon(t,n=n,length=length)
#---------------重构------------------#
def draw_polyline(t,n,length,angle):
    for i in range(n):
        t.fd(length)
        t.lt(angle)
def draw_polygon2(t,length,n):
    angle =360.0 / n
    draw_polyline(t, n, length, angle)
def draw_arc(t,r, angle):
    arc_length = 2 * math.pi * r * angle / 360
    n = int(arc_length / 3) + 1
    step_length = arc_length / n
    step_angle = float(angle) / n
    draw_polyline(t, n, step_length, step_angle)
def draw_circle2(t,r):
    draw_arc(t,r,360)

bob =turtle.Turtle()
#draw_polygon(bob,length=100,n=6)
draw_circle(bob,100)

