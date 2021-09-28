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

data_dir='/home/shahrzad/repos/VascularModeling/data/gcc/'
filename='SimpleVesselGeneratorlog_2_3_2.txt'
f=open(filename, 'r')
             
result=f.read()

subnetworks=result.split('Sub Network Vessels')[1:]    
nodes={}
connected_vessels={}
colors=['r', 'b', 'g']
i=0
fig, ax = plt.subplots()

for sb in subnetworks:
    arteries=sb.split('arteries\n')[1].split('Veins\n')[0].split('\n\n')[:-1]
    veins=sb.split('Veins\n')[1].split('\n\n')[:-1]
    for ar in arteries:
       points=ar.split(': ')[1].split('\t')[0:2]
       node_indices=ar.split(': ')[1].split('\n')[0].split('\t')[3:]
       vessel_index=ar.split(': ')[0]
       connected_vessel_indices=ar.split(': ')[2].split('\n')[0].split(',')[:-1]
       [p1,p2]=points
       if node_indices[0] not in nodes.keys():
           nodes[node_indices[0]]=p1
       if node_indices[1] not in nodes.keys():
           nodes[node_indices[1]]=p2
       
       connected_vessels[vessel_index]=connected_vessel_indices
       x1,y1,_=p1.split(',')
       x2,y2,_=p2.split(',')
       x1=float(x1)
       x2=float(x2)
       y1=float(y1)
       y2=float(y2)
       plt.plot([x1,x2], [y1,y2],color=colors[i],marker='o')
       plt.text(x1,y1,node_indices[0])
       plt.text(x2,y2,node_indices[1])
       # xtickslocs = ax.get_xticks()
       # ymin, _ = ax.get_ylim()
       # print(ax.transData.transform([(xtick, ymin) for xtick in xtickslocs]))

    i=i+1