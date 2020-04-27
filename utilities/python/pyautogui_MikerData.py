# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
批量处理
* 自动编号文件名和目录
* 自动定位保存位置
* 目录使用绝对路径
"""
import pyautogui
import time
#screenWidth, screenHeight = pyautogui.size()
#mouseX, mouseY = pyautogui.position()

pyautogui.PAUSE = 1.5 # 每个函数执行后停顿1.5秒
pyautogui.FAILSAFE = True # 鼠标移到左上角会触发FailSafeException，因此快速移动鼠标到左上角也可以停止

w, h = pyautogui.size()
times = 2

#pyautogui.moveTo(w/2, h/2) # 基本移动
#pyautogui.moveTo(100, 200, duration=2) # 移动过程持续2s完成
#pyautogui.moveTo(202, 178) # 移动到指定位置
#pyautogui.moveTo(None, 500) # X方向不变，Y方向移动到500
#pyautogui.moveRel(-40, 500) # 相对位置移动
for i in range(times):
    pyautogui.click(202, 178, button='left') # 包含了move的点击，右键
    pyautogui.click(445,313,clicks=2, interval=0.25) # 双击，间隔0.25s


    # here the img should be a small piece of the screen. larger screenshot can be time consuming.
    # will be quiet slow
    # 另一个是问题是注意当切换回脚本界面运行时的有时候和程序运行中弹出窗口是有区别的。可以采用外部截图命令。
    # 同时，直截图中不变化和有典型特征的一个小小的片段。
    #im2 = pyautogui.screenshot('my_screenshot.png',region=(622,377,101,46))

    #print(pyautogui.locateOnScreen('my_screenshot.png'))

    time.sleep(18000) # adjust this time to sleep enough or near to the processing time
                      # then tragg the while judgment statement, this would save energy and avoid memory overflow

    tmpLock = str('None')

    while tmpLock=='None':
        tmpLock= str(pyautogui.locateOnScreen('my_screenshot.png',grayscale='True'))
    #time.sleep(40)
    pyautogui.press('down')
    pyautogui.press('enter')
    pyautogui.typewrite('E:\waveBW_'+str(i+1).zfill(3)+'.txt')
    pyautogui.press('enter')
    time.sleep(5)
    pyautogui.hotkey('ctrl','s')
    time.sleep(5)
    pyautogui.typewrite('E:\waveBW_'+str(i+1).zfill(3))
    pyautogui.press('enter')
    time.sleep(5) # this time will also need automatic judgment
    pyautogui.press('enter')
    time.sleep(5)
    pyautogui.press('enter')
#    shut_buttonx, shut_buttony = pyautogui.locateOnScreen('shut_button.png',grayscale='Ture')
#    pyautogui.click(shut_buttonx, shut_buttony)
    pyautogui.click(1258,155) # click the close button on the right upper corner
    pyautogui.press('right')
    pyautogui.press('enter')
    time.sleep(1)

        