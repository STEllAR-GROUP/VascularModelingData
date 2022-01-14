#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 27 15:46:14 2021

@author: shahrzad
"""
import glob
import numpy as np
from matplotlib import pyplot as plt
import pandas
import math
import h5py
import matplotlib
# matplotlib.rcParams.update({'font.size': 20})
# matplotlib.rcParams.update({'lines.linewidth': 3})

directory='/home/shahrzad/repos/VascularModelingData/'
data_dir='2_4_2'
filename=directory+'data/'+data_dir+'/geometry_'+data_dir+'.h5'
# filename='/home/shahrzad/src/VascularModeling/Radiation Modeling Projects/cmake-build-release/Output/test_2_4_2.h5'

def plot_hdf5(filename):
    colors=['r', 'b', 'g','c' ,'m', 'y', 'lime', 'orange','dimgray','peru','olive','tan','plum','rosybrown','teal','pink']

    gens=[]
    f=h5py.File(filename, "r")
    # List all groups
    print("Keys: %s" % f.keys())

    d1=f['GEOM_GROUP']
    vessels=list(d1['GEOM_ARRAY'])
    vessel_nodes=list(d1['NODE_ARRAY'])
    
    # num_partitions=list(f['/'].attrs['Num_Partitions'])[0]
    level=int(np.log2(len(vessels)+2))-1
    ymax=0

    num_gens=int(np.log2(len(vessels)+2)-1)
    levels=[i for i in range(1,num_gens+1)]
    [levels.append(i) for i in range(num_gens,0,-1)]
    middle_xs=[]
    plt.figure(1)
    plt.axes([0, 0, 2, 2])
        
    for i in range(len(vessels)):
        (x1,y1,z1,x2,y2,z2,r)=vessels[i]
        plt.figure(1)
        plt.plot([x1,x2],[y1,y2],color='blue',marker='o')
        middle_x=(x1+x2)/2
        middle_y=(y1+y2)/2
        plt.text(middle_x,middle_y+0.002,i,color='red')
        plt.text(1.05*x1,1.05*y1,vessel_nodes[i][0],color='green')
        plt.text(1.05*x2,1.05*y2,vessel_nodes[i][1],color='green')

        plt.axvline(x1,linestyle='dashed',color='lightgray',linewidth=2)
        plt.axvline(x2,linestyle='dashed',color='lightgray',linewidth=2)
        ymax=max(ymax,y1,y2)
        gens.append(i)
        middle_xs.append(middle_x)
    middle_xs=(list(set(middle_xs)))
    middle_xs.sort()
    for i in range(len(levels)):
        print(levels[i])
        plt.text(middle_xs[i],ymax,levels[i],color='lightgray')
    plt.figure(1)
    plt.savefig(directory+'test_plots/'+data_dir+'.jpg',bbox_inches='tight')


plot_hdf5(filename)

 
