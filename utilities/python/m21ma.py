#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import pandas as pd
import pyautogui
import numpy as np
import time
# user define variable
NumDir = 10 # 设定批量计算的文件夹格式，一个文件内放置了同一个波况的9个算例
# path define
pathname = os.path.abspath('.')
print(pathname)
T = np.linspace(2, 8, 5)
print(T)
H = np.linspace(2, 8, 5)
print(H)
W = np.linspace(2, 8, 5)
print(W)
dir_tmp = os.listdir(pathname)

#os.makedirs('H_'+str(H[0])+'T_'+str(T[0]))

for i in range(NumDir):
    for j in range(len(T)):
        pathdir_tmp = 'H_'+str(H[i])+'T_'+str(T[i])
        os.chdir(pathdir_tmp)
        cmd_exe = 'm21ma.exe '+'H_'+str(H[i])+'T_'+str(T[i])+'W_'+str(W[j])+'.m21ma'
        os.system(cmd_exe)
        Results_dir = os.path.join('.','H_'+str(H[i])+'T_'+str(T[i])+'W_'+str(W[j])+'.m21ma'+' - Result Files')
        for k in range(Results_dir):
            os.system('Mzshell.exe '+ Results_dir[k])
            pyautogui.click(100,100)
            pyautogui.click(100,300)
            pyautogui.press('enter')
            pyautogui.hotkey('altleft','f4')
            Result_tmp = pd.read_csv(Results_dir[k],skiprows=3,sep='\\s+') # w文件名待确定
            # 重新读取列名称
            f = open(Results_dir[k])
            next(f)
            d_tmp =f.readline()
            header_list = d_tmp.split('\t')
            header_list.insert(0, 'Date')
            header_list[-1] = header_list[-1].strip()
            Result_tmp.columns = header_list

           #统计每列的最大值并将结果文件输出到当前目录和追加到汇总报告中
            data_max = Result_tmp.iloc[:,2:].max()
            data_max.to_csv('./max_Results.csv',mode='a') #保存到当前目录，文件名待修改
            data_list = data_max.tolist()
            data_str = str(data_list)
            data_str = data_str.strip(']')
            data_str = data_str.strip('[')
            #追加到汇总报告,给的绝对路径和文件名,Vessel_motion.csv,fender_max_force.csv,
            # bollard_max_force.csv,line_max_force.csv
            with open('max_Results.csv','a') as file_R:
                file_R.write('H_T_W_, '+data_str+'\n')
            file_R.close()