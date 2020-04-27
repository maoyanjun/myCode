#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import csv
import codecs

def data_write_csv(file_name, datas):#file_name为写入CSV文件的路径，datas为要写入数据列表
  file_csv = codecs.open(file_name,'w+','utf-8')#追加
  writer = csv.writer(file_csv, delimiter=' ', quotechar=' ', quoting=csv.QUOTE_MINIMAL)
  for data in datas:
    writer.writerow(data)
  print("保存文件成功，处理结束")

df = pd.read_csv('G:\myCode\python\Kite\Vessel 1_motions.txt',sep='\\s+',skiprows=3)
f = open('G:\myCode\python\Kite\Vessel 1_motions.txt')
next(f)
d =f.readline()
header_list = d.split('\t')
header_list.insert(0, 'Date')
header_list[-1] = header_list[-1].strip()
print(header_list)
print(type(header_list))

print(df.columns)
df.columns = header_list
#print(d)
#df.drop('0')
#print(df[1:5])
#print(df.iloc[:,2])
#df.delete(index=[0])
df.head()
print(df.columns)
print(df)
print(df.iloc[:,2:].max())
data_max = df.iloc[:,2:].max()
data_list = data_max.tolist()
data_str = str(data_list)
data_str = data_str.strip(']')
data_str = data_str.strip('[')
print(data_str)
print(type(data_str))
with open('max_Results.csv','a') as file_R:
    file_R.write('H_T_W_, '+data_str+'\n')
file_R.close()

#for o in range(data_list):
#    data_str=str(data_list[o])+','
#print(data_list)
#print(type(data_list))

#data_frame.to_csv("./max_Results.csv",mode='a', index=False,header=False)
#print(df.iloc[0,:])
#print(df.iloc[1,:])