#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   plot3Dsurfacefigure.py
@Time    :   2020/03/27 11:16:09
@Author  :   Mao Yanjun 
@Version :   1.0
@Contact :   maoyanjun_dut@foxmail.com
@License :   (C)Copyright 1949-2020, DLUT
@Desc    :   None
'''

import pandas as pd
import numpy as np
from matplotlib import pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

dataZ = pd.read_excel('t=150s.xlsx',header=None)
print(dataZ)
dataZ_np = dataZ.values
xx = np.linspace(0.2,40.2,401)
yy = np.linspace(0.2,40.2,201)
print(len(xx))
print(len(yy))
X, Y =np.meshgrid(xx,yy)

fig =plt.figure()
ax3 = plt.axes(projection='3d')

ax3.plot_surface(X,Y,dataZ_np,cmap='rainbow')
plt.xlabel('X (m)')
plt.xlim(0,44)
plt.ylabel('Y (m)')
plt.ylim(-2,42)
ax3.set_zlim(0,)
plt.show()
plt.close()

