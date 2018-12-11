#!/usr/bin/python
#coding=utf-8
"""
Created on 2018/ 9/ 28

@author: Yanjun Mao
"""

import os 
import math
import numpy as np
import matplotlib.pyplot as plt

print
print '#------------------------Input data------------------------#'
print 'Attention: the start time must be a stable surface elevation data'

start_Time = 20
end_Time = 40
wavePeriod = 1.7
waterDepth = 1.0
deltaL12 = 1.0
deltaL13 = 2.5
fft_Num = 1024
bm=(9.8*(wavePeriod**2))/(2*math.pi)
am=bm
L=bm*math.tanh(2*math.pi/bm*waterDepth)
i=1
while i<1000:
    if (L-am)**2<0.000004:
        break
    else:
        am=L
        L=bm*math.tanh(2*math.pi/L*waterDepth)
    i=i+1
waveNumber=2*math.pi/L
print "wave length is ", L
print "wave number is ", waveNumber

pathname = os.path.abspath('./Data')  
Out_File = open('outFile.txt', 'w')  #存储屏幕输出信息
Out_Eta = open('outEta.txt', 'w')  #存储处理后的两个探针数据

DataPath = os.path.join(pathname,'ProbeVOF')  #探针数据所在目录

a = os.listdir(DataPath) #获得探针名称的列表
a.sort() #探针名称排序

fileR = open(os.path.join(DataPath,a[0]), 'r') #打开第一个探针文件
Data = fileR.read() #读取数据
fileR.close()
Data = Data.split('\n') #分行
Data_row=len(Data)-1    #获得行数

raw_Data=np.zeros((Data_row,10))  #创建 Data_row行 10列 的数组
for i in range(len(a)):          #读取探针数据到数组
    filePath = os.path.join(DataPath,a[i])
    raw_Data[...,2*i:2*i+2] = np.loadtxt(filePath)
    
raw_Data=np.delete(raw_Data,range(2,10,2),1) #删除3 5 7 9 列重复的时间数据

for i in range(Data_row-1):  #获得起始、结束时间的下表
    T1=raw_Data[i,0]
    T2=raw_Data[i+1,0]
    if(T1<=start_Time and T2>start_Time):
        numStart=i
        print 'numStart',i
        Out_File.writelines('numStart '+ str(i) +'\n') 
    if(T1<end_Time and T2>=end_Time):
        numEnd=i+1
        print 'numEnd',i+1
        Out_File.writelines('numEnd '+ str(i+1) +'\n')
raw_Data=np.delete(raw_Data,range(numEnd+1,Data_row),0)  #删除结束时间后的数据
raw_Data=np.delete(raw_Data,range(0,numStart),0)  #删除开始时间前的数据

print
print '#----------------Solve average wave period-----------------#'
print

Period=np.zeros((5))  #创建包含5个数据（0.0）的数组

mm=np.zeros((500,5)) #创建包含500行、5列的数组
mk=np.zeros([5],dtype = int) #创建包含5个数据（0）的数组 int类型

for i in  range(1,6):  #数组的 1 2 3 4 5 5个探针数据循环
    k1=0;Time=np.zeros((0))
    for j in range(raw_Data.shape[0]-1):  #所有的行循环
        T1=raw_Data[j,i]
        T2=raw_Data[j+1,i]
        if(T1<=0 and T2>=0):
            Time=np.append(Time,[raw_Data[j,0]])
            mm[mk[i-1],i-1]=j  #存储上跨的下标
            mk[i-1]=mk[i-1]+1  #存储上跨个数（波浪个数-1）
            k1=k1+1 
        #print 'k1= ',k1
    k2=0;T3=0.0
    for k2 in range(k1-1):
        t1=Time[k2]
        t2=Time[k2+1]
        T3=T3+(t2-t1)
    Period[i-1]=T3/(k1-1)
    print 'The period of Num.',i,' probe is : ',Period[i-1]
    Out_File.writelines('The period of Num. '+ str(i) +' probe is : '+str(Period[i-1])+'\n')

print
print '#----------------Solve average wave height-----------------#'   
print

aveH=np.zeros((5))  

mm=np.delete(mm,range(np.min(mk),500),0) #删除数组中 5个探针中最少的波浪个数 至500行的数据
maxH=np.zeros((np.min(mk)-1))  #存储波峰
minH=np.zeros((np.min(mk)-1))  #存储波谷

for i in  range(1,6):
    for j in range(mm.shape[0]-1):
        maxH[j]=np.max(raw_Data[mm[j][i-1]:mm[j+1][i-1],i])#得到临近的两个上跨零点的最大值 即波峰
        minH[j]=np.min(raw_Data[mm[j][i-1]:mm[j+1][i-1],i])#得到临近的两个上跨零点的最小值 即波谷
        aveH[i-1]=(np.sum(maxH)-np.sum(minH))/(np.min(mk)-1)#平均波高
       
    print 'The average wave height of Num.',i,' probe is : ',aveH[i-1]
    Out_File.writelines('The average wave height of Num. '+ str(i) +' probe is : '+str(aveH[i-1])+'\n')

print
print '#-----------------------Interpolation----------------------#' 
print

num1=int((end_Time-start_Time)/wavePeriod)-1 #时间范围内的整数个周期

if (start_Time+num1*wavePeriod) > end_Time : #判断结束时间是否超出范围
  print 'Fetal error in the time interval ! '

raw_Time=raw_Data[:,0]#存储时间数据
raw_eta1=raw_Data[:,1]#存储 #1探针 波面数据
raw_eta2=raw_Data[:,2]#存储 #2探针 波面数据
raw_eta3=raw_Data[:,3]#存储 #3探针 波面数据
	
fft_Time=np.zeros((fft_Num))#存储处理后的fft_Num个时间数据
fft_eta1=np.zeros((fft_Num))#存储处理后的fft_Num个 #1探针 波面数据
fft_eta2=np.zeros((fft_Num))#存储处理后的fft_Num个 #2探针 波面数据
fft_eta3=np.zeros((fft_Num))#存储处理后的fft_Num个 #3探针 波面数据

fft_Dt=num1*wavePeriod/(fft_Num-1)#时间步长

fft_Time[0]=start_Time
fft_eta1[0]=raw_Data[0,1]
fft_eta2[0]=raw_Data[0,2]
fft_eta3[0]=raw_Data[0,3]

for i in range(1,fft_Num):  #得到fft_Num个时间序列
    fft_Time[i]=fft_Time[i-1]+fft_Dt

for i in range(1,fft_Num):#得到fft_Num个波面序列

    for j in range(raw_Time.shape[0]-1):

        if (raw_Time[j]<=fft_Time[i] and fft_Time[i]<raw_Time[j+1]):
            fft_k=(fft_Time[i]-raw_Time[j])/(raw_Time[j+1]-raw_Time[j])
            fft_eta1[i]=fft_k*(raw_eta1[j+1]-raw_eta1[j])+raw_eta1[j]
            fft_eta2[i]=fft_k*(raw_eta2[j+1]-raw_eta2[j])+raw_eta2[j]
            fft_eta3[i]=fft_k*(raw_eta3[j+1]-raw_eta3[j])+raw_eta3[j]
            Out_Eta.writelines(str(fft_eta1[i])+' '+str(fft_eta2[i])+' '+str(fft_eta3[i]) +'\n')


print
print '#-------------FFT to specterum-------------#'
print
eta1_FFT = np.fft.fft(fft_eta1);
eta2_FFT = np.fft.fft(fft_eta2);
eta3_FFT = np.fft.fft(fft_eta3);

abseta1_FFT =abs(eta1_FFT)
eta1_FFTreal =eta1_FFT.real
eta1_FFTimag =eta1_FFT.imag

abseta2_FFT =abs(eta2_FFT)
eta2_FFTreal =eta2_FFT.real
eta2_FFTimag =eta2_FFT.imag

abseta3_FFT =abs(eta3_FFT)
eta3_FFTreal =eta3_FFT.real
eta3_FFTimag =eta3_FFT.imag

Fn=np.zeros((fft_Num))
for i in range(fft_Num):
	Fn[i] = 1/(fft_Dt*fft_Num)*(i)

plt.subplot(3, 1, 1)
plt.plot(Fn,abs(eta1_FFT))
plt.xlabel('$f$ (Hz)')    
plt.ylabel('Amplitude spectrum')
plt.xlim(0,10)
plt.title('G1')
plt.subplot(3, 1, 2)
plt.plot(Fn,abs(eta2_FFT))
plt.xlabel('$f$ (Hz)')    
plt.ylabel('Amplitude spectrum')
plt.xlim(0,10)
plt.title('G2')
plt.subplot(3 ,1, 3)
plt.plot(Fn,abs(eta3_FFT))
plt.xlabel('$f$ (Hz)')    
plt.ylabel('Amplitude spectrum')
plt.xlim(0,10)
plt.title('G3')
plt.subplots_adjust(hspace=0.8)
plt.show()
	
fftETA = open('fftETA.txt', 'w')  #
print len(eta3_FFT)
print len(Fn)
for i in range(len(eta3_FFT)):
    fftETA.writelines(str(Fn[i])+' '+ str(abs(eta3_FFT[i])) +'\n')
print
print '#-------------End FFT to specterum-------------#'
print
print
print '#-------------Solve the reflection coefficient-------------#'
print
maxIndex1 = np.where(abseta1_FFT == max(abseta1_FFT))
maxIndex2 = np.where(abseta2_FFT == max(abseta2_FFT))
maxIndex3 = np.where(abseta3_FFT == max(abseta3_FFT))
print maxIndex1
print maxIndex2
print maxIndex3

An1 =max(abseta1_FFT)/(fft_Num*0.25) #这个地方不知道为什么是0.25 而不是0.5，取单频用了最大值
alpha1 = math.atan2(eta1_FFTimag[maxIndex1],eta1_FFTreal[maxIndex1])

#print eta1_FFTimag[maxIndex1]
#print eta1_FFTimag[10]
#print abs(eta2_FFT[1014])
#print abs(eta2_FFT[10])
#print abs(eta2_FFTimag[1014])
#print abs(eta2_FFTimag[10])
#print abs(eta2_FFTreal[1014])
#print abs(eta2_FFTreal[10])

An2 =max(abseta2_FFT)/(fft_Num*0.25)
alpha2 = math.atan2(eta2_FFTimag[maxIndex2],eta2_FFTreal[maxIndex2])
An3 =max(abseta3_FFT)/(fft_Num*0.25)
alpha3 = math.atan2(eta3_FFTimag[maxIndex3],eta3_FFTreal[maxIndex3])

B1 =complex(An1*math.cos(alpha1),An1*math.sin(alpha1))
B2 = complex(An2*math.cos(alpha2),An2*math.sin(alpha2))
B3 = complex(An3*math.cos(alpha3),An3*math.sin(alpha3))

beta = 2*math.pi*deltaL12/L
gamma = 2*math.pi*deltaL13/L
D = 2*(math.sin(beta)**2 + math.sin(gamma)**2 + math.sin(gamma-beta)**2)
R1 = math.sin(beta)**2 + math.sin(gamma)**2
Q1 = math.sin(beta)*math.cos(beta) + math.sin(gamma)* math.cos(gamma)
R2 = math.sin(gamma)*math.sin(gamma-beta)
Q2 = math.sin(gamma)*math.cos(gamma-beta) -2*math.sin(beta)
R3 = - math.sin(beta)*math.sin(gamma-beta)
Q3 = math.sin(beta)*math.cos(gamma-beta) - 2*math.sin(gamma)
Zi = 1/D* (B1 * complex(R1,Q1) +B2 * complex(R2,Q2) +B3 * complex(R3,Q3))
Zr = 1/D* (B1 * complex(R1,-Q1) +B2 * complex(R2,-Q2) +B3 * complex(R3,-Q3))
InWaveHight = 2*abs(Zi)
RefWaveHight = 2*abs(Zr)
ReflcetionCoefficient = RefWaveHight / InWaveHight
print 'dd'

#plt.plot(Fn,abs(eta1_FFT))
#plt.plot(abs(eta2_FFT))
print 'dd'
print
print '#-------------end Solve the reflection coefficient-------------#'
print



print 'Incident wave hight is : ',InWaveHight
print 'Reflection wave hight is : ',RefWaveHight
print 'Reflection coefficient is : ',ReflcetionCoefficient

Out_File.writelines('Incident wave hight is : '+ str(InWaveHight) +'\n')
Out_File.writelines('Reflected wave hight is : '+ str(RefWaveHight) +'\n')
Out_File.writelines('Reflection coefficient is : '+ str(ReflcetionCoefficient) +'\n')

print
print '#------------Solve the transmission coefficient------------#'
print

print 'Transmission coefficient is : ',aveH[3]/(InWaveHight),' (probe4)'
print 'Transmission coefficient is : ',aveH[4]/(InWaveHight),' (probe5)'

Out_File.writelines('Transmission coefficient is : '+ str(aveH[3]/(InWaveHight)) +' (probe4)'+'\n')
Out_File.writelines('Transmission coefficient is : '+ str(aveH[4]/(InWaveHight)) +' (probe5)' +'\n')

Out_File.close()
Out_Eta.close()
print 'the results have been writen in the outfile'
print
print '#-------------------------Finished-------------------------#'
print
        
raw_input("Press <Enter>...")    


            
        


















