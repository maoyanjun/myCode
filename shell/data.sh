#!/bin/bash

PFAD=log
EXCL=10

# cat   list a files content on a screen / in a pipeline (using "|")
# grep  returns all lines matching a certain string
# cut   cuts out e.g. fields "-f" (here 3rd until END [-]) specified through delminiter "-d' '" (here blanks)
# sed   remove complete lines containing a certain string (here "ClockTime")
# sed-i includes Header
# head  deletes last 10 lines (for scaling reasons, as last lines are often already diverged)
# tr    remove certain strings (here "(" and ")")
#paste  merge two files line by line

################ CLEAR OLD DATA ################
rm -r data

##################### TIME #####################
cat $PFAD | grep 'Time = ' | cut -d' ' -f3- | sed '/ClockTime/d' > Time.dat

############### ORIENTATION  ###############
cat $PFAD | grep 'Orientation' | cut -d' ' -f3- | tr -d '(' | tr -d ')'| tr -d 'Orientation:' | sed -e 's/[\\ \\]/      /g' > orientationTemp.dat

############### LINEAR VELOCITY ################
cat $PFAD | grep 'Linear velocity' | cut -d' ' -f3- | tr -d '(' | tr -d ')' | sed -e 's/[\\ \\]/        /g' > linearVelocityTemp.dat

############### ANGULAR VELOCITY ###############
cat $PFAD | grep 'Angular velocity' | cut -d' ' -f3- | tr -d '(' | tr -d ')' | sed -e 's/[\\ \\]/       /g' > angularVelocityTemp.dat

########## MERGE FILES & ADD HEADER ############
mkdir data
paste Time.dat orientationTemp.dat > data/orientationTemp.dat
sed -i '1i#Time, cos, 0, sin, 0, 1, 0, -sin, 0, cos' data/orientationTemp.dat
head -n -$EXCL data/orientationTemp.dat > data/orientation.dat
paste Time.dat linearVelocityTemp.dat > data/linearVelocityTemp.dat
sed -i '1i#Time, u, v, w' data/linearVelocityTemp.dat
head -n -$EXCL data/linearVelocityTemp.dat > data/linearVelocity.dat
paste Time.dat angularVelocityTemp.dat > data/angularVelocityTemp.dat
sed -i '1i#Time, p, q, r' data/angularVelocityTemp.dat
head -n -$EXCL data/angularVelocityTemp.dat > data/angularVelocity.dat
rm Time.dat
rm orientationTemp.dat
rm data/orientationTemp.dat
rm linearVelocityTemp.dat
rm data/linearVelocityTemp.dat
rm angularVelocityTemp.dat
rm data/angularVelocityTemp.dat
rm plot/*.png