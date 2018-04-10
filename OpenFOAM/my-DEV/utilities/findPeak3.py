#!/usr/bin/python
import re
import os 
pathname = os.path.abspath('./Data/Motion')
fileR = open(os.path.join(pathname,'dealTranslation'), 'r')
dis0 = fileR.read()
fileR.close()
dis0 = dis0.split('\n')
dis0.pop()
fileR = open(os.path.join(pathname,'splitTime'), 'r')
time0=fileR.read()
time0=time0.split('\n')
nums = []
for tmp4 in dis0:
    nums.append(float(tmp4))
peaks = []
troughs = []
for idx in range(3, len(nums)-3):
    if nums[idx-3] < nums[idx] > nums[idx+3]:
        peaks.append((time0[idx], nums[idx]))
    if nums[idx-3] > nums[idx] < nums[idx+3]:
        troughs.append((time0[idx], nums[idx]))
        
print(peaks) # 
print(troughs) #
print(len(peaks))
print(len(troughs))

