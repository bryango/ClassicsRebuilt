#!/bin/bash
# get essential data from IAS/QFT

wget --no-parent --timestamping \
    --reject 'index.html\?C=*,0__,1__*,2__' --rejected-log=rejected.log \
    --mirror https://www.math.ias.edu/QFT/
