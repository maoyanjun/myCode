#!/usr/bin/python
import re
import os 
pathname = os.path.abspath('./Data/Motion')
fileR = open(os.path.join(pathname,'dealTranslation'), 'r')
dis0 = fileR.read()
fileR.close()
dis0 = dis0.split('\n')
dis0.pop()
nums = []
for tmp4 in dis0:
    nums.append(float(tmp4))
print(nums)
peaks = []
troughs = []
for idx in range(1, len(nums)-1):
    if nums[idx-1] < == nums[idx] == > nums[idx+1]:
        print nums[idx]
        peaks.append((idx, nums[idx]))
    if nums[idx-1] == > nums[idx] < == nums[idx+1]:
        troughs.append((idx, nums[idx]))
        
print(peaks) # 
print(troughs) #

