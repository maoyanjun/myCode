#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   pyautogui_MikerData-v1.0.py
@Time    :   2020/03/12 10:51:47
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
import pyautogui
import time
import numpy as np
import os
import shutil

def changetext(orgLine1,changeLine1,orgLine2,changeLine2,fileName,copyFileName):
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
            elif orgLine2 in line:
                line = changeLine2
                f.write('%s\n' %line)
            else:
                f.write('%s\n' %line)
# 设置算例目录,预设T,H,和W的分布规律和组合方式来形成文件名
T = np.linspace(2, 8, 5)
print(T)
H = np.linspace(2, 8, 5)
print(H)
W = np.linspace(2, 8, 5)
dir_tmp = []
print(W)
#dir_tmp = os.listdir(pathname)
#此处range(T) 有待于进一步调整
for i in range(len(T)):
    dir_tmp.append('H_'+str(H[i])+'T_'+str(T[i])) 
    os.makedirs(dir_tmp[i])
#screenWidth, screenHeight = pyautogui.size()
#mouseX, mouseY = pyautogui.position()

    pyautogui.PAUSE = 1.5 # 每个函数执行后停顿1.5秒
    pyautogui.FAILSAFE = True # 鼠标移到左上角会触发FailSafeException，因此快速移动鼠标到左上角也可以停止

    w, h = pyautogui.size()

    #pyautogui.moveTo(w/2, h/2) # 基本移动
    #pyautogui.moveTo(100, 200, duration=2) # 移动过程持续2s完成
    #pyautogui.moveTo(202, 178) # 移动到指定位置
    #pyautogui.moveTo(None, 500) # X方向不变，Y方向移动到500
    #pyautogui.moveRel(-40, 500) # 相对位置移动
    pyautogui.click(20, 66, button='left') # 包含了move的点击，右键
    pyautogui.click(408,310,clicks=2, interval=0.25) # 双击，间隔0.25s


    # here the img should be a small piece of the screen. larger screenshot can be time consuming.
    # will be quiet slow
    # 另一个是问题是注意当切换回脚本界面运行时的有时候和程序运行中弹出窗口是有区别的。可以采用外部截图命令。
    # 同时，直截图中不变化和有典型特征的一个小小的片段。
    #im2 = pyautogui.screenshot('my_screenshot.png',region=(622,377,101,46))

    #print(pyautogui.locateOnScreen('my_screenshot.png'))

    #time.sleep(40)
    pyautogui.press('down')
    pyautogui.press('enter')
    #pyautogui.typewrite('E:\\Mooring\\Hanban\\Hanbanxibo\\TVDMA\\myj\\' + str(dir_tmp[i])+'_FUN'+'\\waveBW.txt') # 此处注意目录的转义字符的设置可能有问题
    pyautogui.typewrite('E:\\Mooring\\Hanban\\Hanbanxibo\\TVDMA\\myj'+'\\waveBW_100.txt') # 此处注意目录的转义字符的设置可能有问题
    pyautogui.press('enter')

    #time.sleep(7200) # adjust this time to sleep enough or near to the processing time
                    # then tragg the while judgment statement, this would save energy and avoid memory overflow

    # 此模块可以自动判断数据是否加载完成
    # 通过while 循环判断软件左下角的坐标标记是否出现决定是否进行
    tmpLock = str('None')

    while tmpLock=='None':
        tmpLock= str(pyautogui.locateOnScreen('my_screenshot.png',grayscale='True')) #换到其他电脑中需要重新截图图片
        print(tmpLock)

    time.sleep(3)
    pyautogui.hotkey('ctrl','s')
    time.sleep(3)
    pyautogui.typewrite('E:\\Mooring\\Hanban\\Hanbanxibo\\TVDMA\\myj\\'+str(dir_tmp[i])+'\\'+str(dir_tmp[i]))
    pyautogui.press('enter')
    time.sleep(5)
    pyautogui.press('enter')
    #    shut_buttonx, shut_buttony = pyautogui.locateOnScreen('shut_button.png',grayscale='Ture')
    #    pyautogui.click(shut_buttonx, shut_buttony)
    pyautogui.click(948,40) # click the close button on the right upper corner
    time.sleep(0.2)
    pyautogui.press('right')
    time.sleep(0.2)
    pyautogui.press('enter')
    time.sleep(1)

        
   # 处理 ma文件 
    os.chdir(dir_tmp[i])
    for j in range(len(W)):
        orgLine1 = '         file_name = |.\H1.2Tp12m0.9thet155.dfs2|\n'
        changeLine1 = '         file_name = |.\\'+dir_tmp[i] +'.dfs2|\n'
        orgLine2 = '         file_name = |..\..\wind200_290-3.dfs0|\n'
        changeLine2 = '         file_name = |..\..\\Ref_'+'W_'+str(W[j])+'.dfs0|\n'
        fileName = 'E:\\Mooring\\Hanban\\Hanbanxibo\\TVDMA\\myj\Refsetup.m21ma'
        copyFileName = dir_tmp[i]+'W_'+str(W[j])+ '.m21ma'
        changetext(orgLine1,changeLine1,orgLine2,changeLine2,fileName,copyFileName)
    os.chdir('..')

