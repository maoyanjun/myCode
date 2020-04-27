#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   m21ma.py
@Time    :   2020/03/12 10:58:24
@Author  :   Mao Yanjun 
@Version :   1.0
@Contact :   maoyanjun_dut@foxmail.com
@License :   (C)Copyright 1949-2020, DLUT
@Desc    :   None
'''
"""
批量处理
* 自动编号文件名和目录
* 自动定位保存位置
* 目录使用绝对路径
"""
import os
import subprocess
import pandas as pd
import pyautogui
import numpy as np
import time
# user define variable
NumDir = 10 # 设定批量计算的文件夹格式，一个文件内放置了同一个波况的9个算例
# path define
#pathname = os.path.abspath('.')
#print(pathname)
T = np.linspace(2, 8, 5)
print(T)
H = np.linspace(2, 8, 5)
print(H)
W = np.linspace(2, 8, 5)
print(W)
#dir_tmp = os.listdir(pathname)

#os.makedirs('H_'+str(H[0])+'T_'+str(T[0]))

for i in range(len(T)):
    pathdir_tmp = 'H_'+str(H[i])+'T_'+str(T[i])
    os.chdir(pathdir_tmp)
    for j in range(len(W)):
        cmd_exe = 'm21ma.exe '+pathdir_tmp+'W_'+str(W[j])+'.m21ma'
        print('>>>> runing the MA exe')
        os.system(cmd_exe)
        print('>>>> finished the running')
        #Results_dir = os.path.join('.',pathdir_tmp+'W_'+str(W[j])+'.m21ma'+' - Result Files')
        Results_dir = pathdir_tmp+'W_'+str(W[j])+'.m21ma'+' - Result Files'
        file_Result_dfs = os.listdir(Results_dir)
        print(file_Result_dfs)
        os.chdir(Results_dir)
        print('>>>> starting postprocessing')
        for k in range(len(file_Result_dfs)):
#            os.system('Mzshell.exe '+ file_Result_dfs[k])
            p = subprocess.Popen('Mzshell.exe '+ file_Result_dfs[k])
#            pyautogui.click(42,63,button='left')
            time.sleep(2)
#            pyautogui.moveTo(45,121,duration=0.2)
            pyautogui.click(52,73,button='left')
            time.sleep(1)
            pyautogui.click(130,339,button='left')
#            pyautogui.moveTo(113,383,duration=0.2)
            time.sleep(1)
            pyautogui.typewrite('E:\\Mooring\\Hanban\\Hanbanxibo\\TVDMA\\myj\\'+pathdir_tmp +'\\'+Results_dir+'\\'+file_Result_dfs[k][:-5]+'.txt')
            pyautogui.press('enter')
            time.sleep(2)
            p.kill()
#            pyautogui.hotkey('altleft','f4')

            Result_tmp = pd.read_csv('.\\'+ file_Result_dfs[k][:-5]+'.txt',skiprows=3,sep='\\s+') # 此处获取的文件名可能和保存的不一样的,可能带后缀
            # 重新读取列名称
            f = open(file_Result_dfs[k][:-5]+'.txt')
            next(f)
            d_tmp =f.readline()
            header_list = d_tmp.split('\t')
            header_list.insert(0, 'Date')
            header_list[-1] = header_list[-1].strip()
            Result_tmp.columns = header_list

            #统计每列的最大值并将结果文件输出到当前目录和追加到汇总报告中
            # 此部分统计工作有待于进一步的增加统计函数进行扩展
            data_max = Result_tmp.iloc[:,2:].max()
            data_max.to_csv(file_Result_dfs[k][:-4]+'_max.csv',mode='w',header='True') #保存到当前目录，文件名待修改
            data_list = data_max.tolist()
            data_str = str(data_list)
            data_str = data_str.strip(']')
            data_str = data_str.strip('[')
            #追加到汇总报告,给的绝对路径和文件名,Vessel_motion.csv,fender_max_force.csv,
            # bollard_max_force.csv,line_max_force.csv
            with open('..\\..\\'+ file_Result_dfs[k][:-4]+'_max.csv','a') as file_R:
                file_R.write(str(H[i])+','+str(T[i])+','+str(W[j])+','+ data_str+'\n')
            file_R.close()
        print('>>>> finished postprocessing and continue calculating next dir')
        os.chdir('..')