#!/usr/bin/python
#set the script in the top dictionary,and execute it py tpye "python ChangesParameters.py"
import os 

pathname = os.path.abspath('.')
# List of time dirs in order
a = os.listdir(pathname)
a.remove('ChangesParameters.py')
#a.remove('script.sed')
#print a
a.sort()
print 'these are all the dictionaries in the work path:'
print a
for i in range(len(a)):
    print 'this is the courent work path:'
    print a[i]
    postname=os.path.join(pathname,a[i])
    dir1 = os.path.join(postname,'0.org')
    #print dir1
    dampingCoeff=raw_input("input the dampingCoeff: ")
    f=open('script.sed','w')
    f.write('/coeff/c\            coeff         '+str(dampingCoeff)+';')
    f.close()
    os.system('sed -i -f script.sed' +' '+dir1+'/pointDisplacement')

print 'Done'
