#!/bin/sh

# Part 2
# Semi-generic script to get and install github archive
# Author: Howard Webb
# Date: 11/16/2017
# Create directories
# Install libraries, including CouchDB and OpenCV
# Set up variables
# Test the System
# Load cron to automate

#######################################

TARGET=/home/pi/MVP
PYTHON=$TARTET/python

# Run the release specific build script

# Declarations
RED='\033[31;47m'
NC='\033[0m'

# Exit on error
error_exit()
{
	echo ${RED} $(date +"%D %T") "${PROGNAME}: ${1:="Unknown Error"}" ${NC} 1>&2
	exit 1
}

# Update what have
sudo apt-get update

# Build directories
mkdir -p $TARGET || error_exit "Failure to build MVP directory"
cd $TARGET
mkdir -p data
mkdir -p logs
mkdir =p pictures
echo $(date -u) "directories created"

# Install Libraries

# FS Webcam
sudo apt-get install fswebcam -y || error_exit "Failure to install fswebcam (USB Camera support)"
echo  $(date +"%D %T") "fswebcam intalled (supports USB camera"

# Used for charting
sudo pip install pygal|| error_exit "Failure to install pygal (needed for charting)"
echo  $(date +"%D %T") "pygal installed (used for charting)"

# CouchDB python library
# http://pythonhosted.org/CouchDB

pip install  pycouchdb || error_exit "Failure to install CouchDB Python library"
echo  $(date +"%D %T") "CouchDB Python Library intalled"

# OpenCV library
# https://www.raspberrypi.org/forums/viewtopic.php?t=142700
# numpy dependency

sudo apt-get install python-numpy -y || error_exit "Failure to install numpy math library"
echo  $(date +"%D %T") "numpy Library intalled"

sudo apt-get install python-scipy -y || error_exit "Failure to install scipy science library"
echo  $(date +"%D %T") "scipy Library intalled"

sudo apt-get install ipython -y || error_exit "Failure to install ipython library"
echo  $(date +"%D %T") "ipython Library intalled"

sudo apt-get install libopencv-dev python-opencv -y || error_exit "Failure to install opencv (computer vision) library"
echo  $(date +"%D %T") "opencv Library intalled"

#Create variables
# Build the environment information

python $PYTHON/buildEnv.py || error_exit "Failure to build environment variables"
echo  $(date +"%D %T") "Environment variables built"


sudo bash /home/pi/MVP/scripts/render.sh
echo $(date +"%D %T") "System PASSED"

# Load Cron
crontab /home/pi/scripts/MVP_cron.txt

echo $(date +"%D %T") "Your MVP is now running"
reboot