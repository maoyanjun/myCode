#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   def_functions.py
@Time    :   2020/03/19 10:40:24
@Author  :   Mao Yanjun 
@Version :   1.0
@Contact :   maoyanjun_dut@foxmail.com
@License :   (C)Copyright 1949-2020, DLUT
@Desc    :   None
'''
import numpy as np
import math

def changetext(orgLine1,changeLine1,fileName,copyFileName):
    with open(fileName,'r',encoding='utf-8') as f:
        lines =[]
        for line in f.readlines():
            if line!='\n':
                lines.append(line)
    f.close()
    with open(copyFileName, 'w',encoding='utf-8') as f:
        for line in lines:
            if orgLine1 in line:
                line = changeLine1
                f.write('%s\n' %line)
            else:
                f.write('%s\n' %line)
#
def changetext2(orgLine1,changeLine1,orgLine2,changeLine2,fileName,copyFileName):
    with open(fileName,'r',encoding='utf-8') as f:
        lines1 =[]
        for line1 in f.readlines():
            if line1!='\n':
                lines1.append(line1)
    f.close()
    with open(copyFileName, 'w',encoding='utf-8') as f:
        for line1 in lines1:
            if orgLine1 in line1:
                line1 = changeLine1
                f.write('%s\n' %line1)
            elif orgLine2 in line1:
                line1 = changeLine2
                f.write('%s\n' %line1)
            else:
                f.write('%s\n' %line1)
    f.close()

def del_files(path):
    for root,dirs,files in os.walk(path):#（使用 os.walk ,这个方法返回的是一个三元tupple(dirpath(string), dirnames(list), filenames(list)), 其中第一个为起始路径， 第二个为起始路径下的文件夹, 第三个是起始路径下的文件.）
        for name in files:
            if '_0' in name:#判断某一字符串是否具有某一字串，可以使用in语句
                os.remove(os.path.join(root,name))##os.move语句为删除文件语句

            print('Delete files:',os.path.join(root,name))   

def upCross1(dataMotion):
    L = len(dataMotion)
    #print(L)
    PeakVestValue = []
    H = []
    i = 1
    j = 1
    q = 1
    while i+2<L:
        tmp_peak = dataMotion[i]
        while dataMotion[i]>0 and i+2<L:
            #print('processing the peak value')
            if dataMotion[i-1]<= dataMotion[i] and dataMotion[i] >=dataMotion[i+1] and dataMotion[i]>=tmp_peak :
                tmp_peak = dataMotion[i]
                #print(tmp_peak)
                q = 2
            i = i+1
        if q == 2:
            PeakVestValue.append(tmp_peak)
            j = j+1
        k= 1
        tmp_peak = dataMotion[i]
        while dataMotion[i]<=0 and i+2<L:
            #print('processing the valley value')
            if dataMotion[i-1]>= dataMotion[i] and dataMotion[i] <=dataMotion[i+1] and dataMotion[i]<= tmp_peak:
                tmp_peak = dataMotion[i]
                k = 2
            i = i+1
        if k == 2:
            PeakVestValue.append(tmp_peak)
            j = j+1
    #print(PeakVestValue)
    tmp_stepValue = np.arange(0,len(PeakVestValue)-1,2)
    for i in tmp_stepValue:
        H.append(abs(PeakVestValue[i]-PeakVestValue[i+1])) 
    H.sort(reverse=True)
    asec = math.floor(len(H)/3)
    top1of31 = np.array(H[:asec])
    meanTop1of31 = np.mean(top1of31)
    maxMotion = np.max(top1of31)
    return meanTop1of31 , maxMotion

def upCross2(dataMotion):
    L = len(dataMotion)
    #print(L)
    PeakVestValue = []
    H = []
    i = 1
    j = 1
    q = 1
    while i+2<L:
        tmp_peak = dataMotion[i]
        while dataMotion[i]>0 and i+2<L:
            #print('processing the peak value')
            if dataMotion[i-1]<= dataMotion[i] and dataMotion[i] >=dataMotion[i+1] and dataMotion[i]>=tmp_peak :
                tmp_peak = dataMotion[i]
                #print(tmp_peak)
                q = 2
            i = i+1
        if q == 2:
            PeakVestValue.append(tmp_peak)
            j = j+1
        k= 1
        tmp_peak = dataMotion[i]
        while dataMotion[i]<=0 and i+2<L:
            #print('processing the valley value')
            if dataMotion[i-1]>= dataMotion[i] and dataMotion[i] <=dataMotion[i+1] and dataMotion[i]<= tmp_peak:
                tmp_peak = dataMotion[i]
                k = 2
            i = i+1
        if k == 2:
            PeakVestValue.append(tmp_peak)
            j = j+1
    #print(PeakVestValue)
    for i in range(len(PeakVestValue)):
        H.append(abs(PeakVestValue[i])) 
    H.sort(reverse=True)
    asec = math.floor(len(H)/3)
    top1of31 = np.array(H[:asec])
    meanAbsTop1of31 = np.mean(top1of31)
    return meanAbsTop1of31
#    for i in range(len(PeakVestTime)):
#        H.append(abs(PeakVestValue[i])) 
#    return H