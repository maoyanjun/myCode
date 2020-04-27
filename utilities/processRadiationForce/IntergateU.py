#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    Date: 2019-03-19
    Author: Maoyanjun(毛艳军)
    Email: maoyanjun_dut@foxmail.com
    HomePage: http://maoyanjun.top
    LastChange: 2019-03-19 09:48:31
    History:
    Discription: This python script is used for extracting sample data from time dir
                 and use the horizontal velocity and pressure to calcualte the 
                 radiation force then list the result in Data/IntegrateU for every sensor
    Copyright: GNU General Public License
"""

#waterDepth = float(raw_input("input the Reference water depth:"))

# set the variables for current workspace and the location of the data
pathname = os.path.abspath('.')
savePath = os.path.join(pathname,'Data/RadiationForce')
if not os.path.isdir(savePath):
    os.makedirs(savePath)
# This corresponds to the data of alpha.water and p 
postPath = os.path.join(pathname,'postProcessing2')
if os.path.isdir(postPath):
    postPath = 'postProcessing2/sets'
else:
    postPath = 'sets'

# This corresponds to the data of U

postPath1 = os.path.join(pathname,'postProcessing')
if os.path.isdir(postPath):
    postPath1 = 'postProcessing/sets'
else:
    postPath1 = 'sets'

# List of time dirs in order
a = os.listdir('./'+postPath)
a.sort(lambda a,b: cmp(float(a), float(b)))

# List of time dirs in order in the U file directory
a1 = os.listdir('./'+postPath1)
a1.sort(lambda a,b: cmp(float(a), float(b)))

# Get number of sensors and the index name of the p and alpha.water field
dir1 = os.path.join(pathname,postPath,a[int(len(a)/2.0)])
b = os.listdir(dir1)
b.sort(key= lambda x:int(x[6:-17]))

#debug
#print b
#print len(b)

nSens = 0
index = []
for i in range(len(b)):
    test1 = b[i].find('alpha.water') 
    test2 = b[i].find('p') 
    if test1 and test2:
        index.append(i)
        nSens += 1

#debug
#print index

# get the index name of the U file
dir2 = os.path.join(pathname,postPath1,a1[int(len(a1)/2.0)])
b1 = os.listdir(dir2)
b1.sort(key= lambda x:int(x[6:-5]))

index1 = []
for i in range(len(b1)):
    test3 = b1[i].find('U') 
    if test3:
        index1.append(i)

#debug
#print index1
#print b1


for i in range(nSens):
    # Create files to write
    fileName = b[index[i]][6:b[index[i]].find('l')-2]
    fileW = open(os.path.join(savePath,fileName), 'w')
    print 'Sensor ' + '%i' % int(i+1) + ' of ' + '%i' % nSens + '.'

    # Read files time by time
    for j in range(len(a)):
        directory = os.path.join(pathname,postPath,a[j])

        #debug
        #print directory
        #print a[j]

        try:
            #print os.path.join(directory,b[index[i]])

            fileR = open(os.path.join(directory,b[index[i]]), 'r')
        except:
            #There is a warning problem need to be solved
            #print 'WARNING - File not present: ' + os.path.join(directory,b[index[i]])
            continue
        else:
            data = fileR.read()
            fileR.close()
            data = data.split('\n')
                      
            
            position = []
            alpha_raw = []
            p_raw = []
    
            # x y z alpha1 calculation
            for k in range(len(data)-1):
                line = data[k]
                line = line.split('\t') 
                
                position.append(float(line[0]))
                alpha_raw.append(float(line[1]))
                p_raw.append(float(line[2]))

            #debug
            #print position
            #print alpha_raw
            #print p

                      
            #try to open the U data              
            directory1 = os.path.join(pathname,postPath1,a1[j])
            try:
                fileR1 = open(os.path.join(directory1,b1[index1[i]]), 'r')
            except:
                print 'WARNING - File not present: ' + os.path.join(directory1,b1[index[i]])
            else:

                # split the U data    
                data1 = fileR1.read()
                fileR1.close()
                data1 = data1.split('\n')
                
                U_raw = []
        
                # x y z alpha1 calculation
                for k in range(len(data1)-1):
                    line1 = data1[k]
                    line1 = line1.split('\t') 
                    
                    U_raw.append(float(line1[1]))

                #debug
                #print U_raw
        
            # Integrate the horizontal water velocity along the water depth
            Radiation_Force = 0
            rho =1000.0

            for k in range(len(position)-1):
                if (alpha_raw[k]>=0.5):
                    Radiation_Force += rho*U_raw[k]**2+p_raw[k]
          
            # Write to file
            time = a[j]
            fileW.write(time + ' ' + '%.6f' % Radiation_Force + '\n')

    fileW.close()

print 'Done'


