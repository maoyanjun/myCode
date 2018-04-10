#!/usr/bin/python
# -*- coding: utf-8 -*-
__author__ = 'maoyanjun'
__date__ = '2017-12-10'
#set the script in the top dictionary,and execute it py tpye "python ChangesParameters.py"
import shutil,os 

pathname = os.path.abspath('.')
Dataname=os.path.join(pathname,'DATA/')
# List of time dirs in order
a = os.listdir(pathname)
#删除多余的不需要遍历的文件或者文件夹
a.remove('ChangesParameters.py')
a.remove('script.sed')
a.remove('CopeData.py')
a.remove('DATA')
#print a
a.sort()
print 'these are all the dictionaries in the work path:'
print a
for i in range(len(a)):
    print 'this is the courent work path:'
    print a[i]
    postname=os.path.join(pathname,a[i])
    dir1 = os.path.join(postname,'Data/Motion')
    dir2 = os.path.join(postname,'Data/ProbeVOF')
    #print dir1
    #将lsit元素是字符串来处理，进行切片获得周期
    Period=a[i][1:5]
    #此处目录和下文件的定义用os.path.join()比较好
    #复制运动响应
    shutil.copy(os.path.join(dir1,'splitTime'),os.path.join(pathname,'DATA/')+'T'+str(Period)+'splitTime')
    shutil.copy(os.path.join(dir1,'splitTranslation'),os.path.join(pathname,'DATA/')+'T'+str(Period)+'splitTranslation')
    shutil.copy(os.path.join(dir1,'splitVelocity'),os.path.join(pathname,'DATA/')+'T'+str(Period)+'splitVelocity')
    
    #复制波浪探针，此处还可以化简系数处理，暂时先不做
    #shutil.copy(os.path.join(dir2,'ProbeVOF3'),os.path.join(pathname,'DATA/ProbeVOF')+'T'+str(Period)+'ProbeVOF3')
    #shutil.copy(os.path.join(dir2,'ProbeVOF4'),os.path.join(pathname,'DATA/ProbeVOF')+'T'+str(Period)+'ProbeVOF4')
    #shutil.copy(os.path.join(dir2,'ProbeVOF5'),os.path.join(pathname,'DATA/ProbeVOF')+'T'+str(Period)+'ProbeVOF5')
    #shutil.copy(os.path.join(dir2,'ProbeVOF6'),os.path.join(pathname,'DATA/ProbeVOF')+'T'+str(Period)+'ProbeVOF6')
   

print 'Done'
print 'Author:',__author__
print 'date:',__date__
