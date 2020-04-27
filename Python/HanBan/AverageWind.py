#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   AverageWind.py
@Time    :   2020/03/26 21:45:15
@Author  :   Mao Yanjun 
@Version :   1.0
@Contact :   maoyanjun_dut@foxmail.com
@License :   (C)Copyright 1949-2020, DLUT
@Desc    :   None
'''

import pandas as pd
import numpy as np
import os
path = os.path.abspath('./')
print(path)
dataWind = pd.read_csv('data.txt',sep='\\s+')
dataWind_np = dataWind.values
j = 0
Dir_data = []
Vel_data = []
for i in range(int(dataWind_np.shape[0]/30)):
    tmp_Dir=np.mean(dataWind_np[j:j+30,0])
    tmp_Vel=np.mean(dataWind_np[j:j+30,1])
    j = j+30
    Dir_data.append(tmp_Dir)
    Vel_data.append(tmp_Vel)
#print(Dir_data)
#print(Vel_data)
Dir_data = str(Dir_data)
Dir_data = Dir_data.strip('[')
Dir_data = Dir_data.strip(']')
Vel_data = str(Vel_data)
Vel_data = Vel_data.strip('[')
Vel_data = Vel_data.strip(']')
with open('windVelocity.csv','a') as fileR:
    fileR.write(Dir_data+'\n')
    fileR.write(Vel_data)
fileR.close()