#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    Date: 2019-01-04
    Author: Maoyanjun
    Email: maoyanjun_dut@foxmail.com
    HomePage: http://maoyanjun.top
    LastChange: 2019.01.07.22:16(星期一)
    History:
    Discription: to plot one single wave surface elevation based on the given 
                gauge number compared with the theory result.
    Function: 1. input given gauge number
              2. X shift,Y shift
              3. plot the magnitude spectrum
              4. control the font size of the tile, axis name the text label,
                 lengend.
              5. the line format: color, marker, line width,
"""
import os 
from pylab import *

# gaussian_filter to smooth the line in 1d
from scipy.ndimage.filters import gaussian_filter1d

# User input or modify informatin to plot single figure based on the input gauge number
gauge_Num = raw_input("please input the gauge number: ")
X_shift = raw_input("input the x phase shift,default is 0: ")
Y_shift = raw_input("input the y phase shift,default is 0: ")
#f_s = raw_input("input the sampling time space: ")
f_s = 0.05
gauge_name = "ProbeVOF" + gauge_Num 

# working file path, need to be modified before using.
pathname = os.path.abspath('./Data')
readPath = os.path.join(pathname,'ProbeVOF')

# get the list of all the files in the readPath for automatic process
a = os.listdir(readPath)

# Sorting
remove = []
for i in range(len(a)):
    if (a[i].rfind('.')+1): # Includes point
        remove.append(i)
remove.reverse()
for i in remove:
    a.pop(i)
a.sort(lambda a,b: cmp(int(a.split('F')[1]), float(b.split('F')[1])))

# Plot  

# read the theory wave surface, the data structure is two column seperted by space
fileR_theory = open(os.path.join(pathname,'ThoryFocusWaveSurface.txt'))
data_theory = fileR_theory.read()
fileR_theory.close
data_theory = data_theory.split('\n')
x1 = []
y1 = []

for i in range(len(data_theory)-1):
    line_2 = data_theory[i]
    line_2 = line_2.split(' ')
    x1.append(float(line_2[0]))
    y1.append(float(line_2[1]))

# filePath = os.path.join(readPath,"ProbeVoF")
fileR = open(os.path.join(readPath,gauge_name), 'r')
data = fileR.read()
fileR.close()
data = data.split('\n')
x = []
y = []
for i in range(len(data)-1):
    line = data[i]
    line = line.split(' ') 
    x.append(float(line[0])+ float(X_shift))
    y.append(float(line[1])+ float(Y_shift))

# translate the time domain to frequence domain by fft Fourier translation
y_fft = np.fft.fft(y)
y1_fft = np.fft.fft(y1)

# use to smoot the rusult for ploting
#y_fft_smooth = gaussian_filter1d(abs(y_fft),sigma =0.5)

#calculation the frequece for the x-axis in frequence domain based on the sampling time intrval.
xf =np.linspace(0,1/float(f_s),len(y_fft))
xf1 =np.linspace(0,1/float(f_s),len(y1_fft))
#y_fft = np.fft.fft(y[:512])
#y1_fft = np.fft.fft(y1[:512])
#xf =np.arange(len(y[:512]))
#x1f =np.arange(len(y1[:512]))

#plot setup
# set the fig size in inch unit
plt.figure(figsize=(10,5.71))
#tight_layout()

# control the distance between sub figures by the percent of the figure size.
plt.subplots_adjust(wspace=0.25,hspace=0)
title_name = "ProbeVOF" + gauge_Num + "(Xs= %s)"%X_shift +"(Ys= %s)"%Y_shift
subplot(1,2,1)

plot(x,y,'r-',lineWidth=4.0,label="present num")
plot(x1,y1,'g-.',lineWidth=4.0,label="theory")

# set the x and y axis data zone
xlim([10,20])
ylim([-0.05,0.08])

# set the x and y axis label with sting or string type variable
xlabel('t (s)',fontsize=18)    
ylabel('$h + \eta$ (m)',fontsize=18)

#set the font size of the axis ticks numbers
xticks(fontsize=15)
yticks(fontsize=15)

#show the title
title(title_name)

#font1 = {
#'weight' : 'normal',
#'size'   : 10,
#}
#legend(loc='upper left',prop=font1)
#legend(loc='upper left',fontsize=10)

# add text content in the figure anchoring in the given coordinate value
#plt.text(15,0,'X_shift= %s'%X_shift)

# add legend by the given label,loc =0 means locating automaticly
legend(loc=0,fontsize=13)


subplot(1,2,2)
xlim([0,10])
plot(xf,abs(y_fft),lineWidth=4.0,label="present num")
plot(xf1,abs(y1_fft),lineWidth=4.0,label="theory")
#legend(loc='upper right',fontsize=10)
legend(loc=0,fontsize=13)
xlabel('$f$ (Hz)',fontsize=18)    
ylabel('magnitude',fontsize=18)
xticks(fontsize=15)
yticks(fontsize=15)
title('Magnitude specturm')

# save the fig with given name. dpi =80 is proper for instant view,dpi =600 for high quality image with large size.
savefig('./Data/surfaceElevation%s'%gauge_Num,dpi=600)# this joints the string and varibles

# finally show the figures by this command
show()


