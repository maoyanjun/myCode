# -*- coding: utf-8 -*-
"""
Created on Fri Apr  7 14:44:32 2017

@author: zxy
"""

import os
import time
import shutil

Num=4          # Num. processor
deltaT=0.5     #deltaT for backup 
sleeptime=120    #sleeptime

pathname =os.path.abspath('.')
path1=os.path.join(pathname,'postProcessing')
if not os.path.isdir(path1):
    os.mkdir('postProcessing')
path2=os.path.join(pathname,'backup')
if not os.path.isdir(path2):
    os.mkdir('backup')
 
 
initialfile=os.listdir('./')

while True :

    a =os.listdir('./'+'processor'+str(0))
    a.remove('constant')
    a.remove('0')
    if len(a) == 0:
        time.sleep(sleeptime)
        continue
    a.sort(lambda a,b: cmp(float(a),float(b)))    
    os.system("reconstructPar -fields '(alpha.water U p p_rgh)'")   

    for i in range(Num):
        for j in range(len(a)):
            print 'delete ',a[j],'in processor',i
            dir1=os.path.join(pathname,'processor'+str(i),a[j])
            shutil.rmtree(dir1)
    b =os.listdir('./')
    for k in range(len(initialfile)):
        b.remove(initialfile[k])
    b.sort(lambda a,b: cmp(float(a),float(b)))
    os.system('sample -time 20:')
    for m in range(len(b)):
        dir2=os.path.join(pathname,b[m])
        dir0=os.path.join(pathname,'backup',b[m])
        if (abs(float(b[m])%deltaT) <= 1e-5 or abs(float(b[m])%deltaT-deltaT) <= 1e-5):
            if os.path.isdir(dir0):
                shutil.rmtree(dir0)                
            shutil.copytree(dir2,dir0)
        shutil.rmtree(dir2)        
    time.sleep(sleeptime)

