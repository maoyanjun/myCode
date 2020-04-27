#!/usr/bin/env python
# -*- encoding: utf-8 -*-
#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   m21ma-v2.0.py
@Time    :   2020/03/24 11:52:03
@Author  :   Mao Yanjun 
@Version :   2.0
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
import shutil
import glob
import subprocess
import pandas as pd
import pyautogui
import numpy as np
import time
import def_functions2
# user define variable
NumDir = 10 # 设定批量计算的文件夹格式，一个文件内放置了同一个波况的9个算例
startTime = 4800
timeStep = 0.25
#timeGlobal = 
#EndTime =
# path define
pathname = r'E:\Mooring\Hanban\Hanbanxibo\TVDMA\MA'
workSpace =  '\\1TP10'
print(pathname)
dir_tmp = os.listdir(pathname+'\\1TP10')
print(dir_tmp)
dir_Ref = r'E:\Mooring\Hanban\Hanbanxibo\TVDMA\MA\RefMASetups'
MAfile_Ref = os.listdir(dir_Ref)

T = np.linspace(2, 8, 5)
print(T)
H = np.linspace(2, 8, 5)
print(H)
W = np.linspace(2, 8, 5)
print(W)
os.chdir(pathname+'\\1TP10')
for i in range(len(dir_tmp)):
    dir_FUN_tmp = dir_tmp[i]
    dir_MAcase_tmp = dir_tmp[i][:-4]
    os.makedirs(dir_MAcase_tmp)
    fileName_tmp = glob.glob(dir_FUN_tmp+'/*.dfs2')
    print(fileName_tmp)
    shutil.move(fileName_tmp[0], dir_MAcase_tmp+'/'+dir_MAcase_tmp+'.dfs2')
    #shutil.copy(fileName_tmp[0], dir_MAcase_tmp+'/'+dir_MAcase_tmp+'.dfs2')
    for k in range(len(MAfile_Ref)):
        orgLine1 = '         file_name = |.\H0.8Tp12m0.9thet180.dfs2|\n'
        changeLine1 = '         file_name = |.\\'+dir_MAcase_tmp +'.dfs2|\n'
        fileName = dir_Ref+'/'+MAfile_Ref[k]
        copyDirname  = dir_MAcase_tmp+'/'+dir_MAcase_tmp+MAfile_Ref[k]
        MA_casefile = dir_MAcase_tmp+MAfile_Ref[k]
        def_functions2.changetext(orgLine1,changeLine1,fileName,copyDirname)

        #shutil.copy(dir_Ref+'/'+MAfile_Ref[i],dir_MAcase_tmp+'/'+MA_casefile)
        os.chdir(dir_MAcase_tmp)
        cmd_exe = 'm21ma.exe '+MA_casefile
        print('>>>> runing the MA exe')
        os.system(cmd_exe)
        print('>>>> finished the running')

        #Results_dir = os.path.join('.',pathdir_tmp+'W_'+str(W[j])+'.m21ma'+' - Result Files')
        Results_dir = MA_casefile+' - Result Files'
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
            pyautogui.click(517,86,button='left')
            time.sleep(1)
            pyautogui.click(590,353,button='left')
#            pyautogui.moveTo(113,383,duration=0.2)
            time.sleep(2)
            pyautogui.typewrite(pathname+workSpace+'\\'+ dir_MAcase_tmp+'\\'+Results_dir+'\\'+file_Result_dfs[k][:-5]+'.txt')
            pyautogui.press('enter')
            time.sleep(2)
            pyautogui.press('enter')
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
            data_max = Result_tmp.iloc[int(startTime/timeStep):,2:].max()
            data_max.to_csv(file_Result_dfs[k][:-4]+'_max.csv',mode='w',header='True') #保存到当前目录，文件名待修改
            data_list = data_max.tolist()
            data_str = str(data_list)
            data_str = data_str.strip(']')
            data_str = data_str.strip('[')
            MotionSig =np.zeros(6)
            MotionSigAbs =np.zeros(6)
            if file_Result_dfs[k][:-5] == 'Vessel_1_motions':
                dataM_np = Result_tmp.values
                for l in range(6):
                    MotionSig[l] = def_functions2.upCross1(dataM_np[int(startTime/timeStep):,l+2])
                    MotionSigAbs[l] = def_functions2.upCross2(dataM_np[int(startTime/timeStep):,l+2])
                MotionSigStr = str(MotionSig)
                MotionSigStr = MotionSigStr.strip(']')
                MotionSigStr = MotionSigStr.strip('[')
                MotionSigStr = ','.join(MotionSigStr.split())
                MotionSigAbsStr = str(MotionSigAbs)
                MotionSigAbsStr = MotionSigAbsStr.strip(']')
                MotionSigAbsStr = MotionSigAbsStr.strip('[')
                MotionSigAbsStr = ','.join(MotionSigAbsStr.split())
                with open('..\\..\\'+ file_Result_dfs[k][:-4]+'_max_sig.csv','a') as file_R:
                    file_R.write(Results_dir[2:5]+','+Results_dir[7:9]+','+Results_dir[13:16]+','+Results_dir[16:19]+','+Results_dir[24]+','+ data_str+','+MotionSigStr+','+MotionSigAbsStr+'\n')
                file_R.close()

            #追加到汇总报告,给的绝对路径和文件名,Vessel_motion.csv,fender_max_force.csv,
            # bollard_max_force.csv,line_max_force.csv
            else:
                with open('..\\..\\'+ file_Result_dfs[k][:-4]+'_max.csv','a') as file_R:
                    file_R.write(Results_dir[2:5]+','+Results_dir[7:9]+','+Results_dir[13:16]+','+Results_dir[16:19]+','+Results_dir[24]+','+ data_str+'\n')
                file_R.close()
        print('>>>> finished postprocessing and continue calculating next dir')
        os.chdir('../../')