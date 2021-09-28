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


# fig, ax = plt.subplots()

def plot_network(vessels,i,nodes,connected_vessels):
    for ves in vessels:
       points=ves.split(': ')[1].split('\t')[0:2]
       node_indices=ves.split(': ')[1].split('\n')[0].split('\t')[3:]
       vessel_index=ves.split(': ')[0]
       connected_vessel_indices=ves.split(': ')[2].split('\n')[0].split(',')[:-1]
       [p1,p2]=points
       if node_indices[0] not in nodes[i].keys():
           nodes[i][node_indices[0]]=p1
       if node_indices[1] not in nodes[i].keys():
           nodes[i][node_indices[1]]=p2
       
       connected_vessels[i][vessel_index]=connected_vessel_indices
       x1,y1,_=p1.split(',')
       x2,y2,_=p2.split(',')
       x1=float(x1)
       x2=float(x2)
       y1=float(y1)
       y2=float(y2)
       plt.figure(1)
       plt.plot([x1,x2], [y1,y2],color=colors[i],marker='o')
       plt.text(x1,y1,node_indices[0])
       plt.text(x2,y2,node_indices[1])

def plot_general(all_vessels):
    vessels=[]
    middles=[]
    levels=[]
    ymax=0
    xmax=0
    for ves in all_vessels:
        rank=int(ves.split(': ')[0].split(',')[0])
        vessel_index=ves.split(': ')[0].split(',')[1]
        points=ves.split(': ')[1].split('\t')[0:2]        
        [p1,p2]=points       
        node_indices=ves.split(': ')[1].split('\n')[0].split('\t')[3:]
        
        x1,y1,_=p1.split(',')
        x2,y2,_=p2.split(',')
        x1=float(x1)
        x2=float(x2)
        y1=float(y1)
        y2=float(y2)

        plt.figure(1)
        plt.axes([0, 0, 3, 3])

        plt.plot([x1,x2], [y1,y2],color=colors[rank],marker='o')
        plt.text(x1,y1,node_indices[0])
        plt.text(x2,y2,node_indices[1])
        ymax=max(y1,y2,ymax)
        xmax=max(x1,x2,xmax)
        middle=(x1+x2)/2
        level=x1
        if level not in levels:
            levels.append(level)            
        if middle not in middles:            
            middles.append(middle)
        
    middles.sort()
    levels.sort()

    j=0
    for (middle, level) in zip(middles,levels):
        plt.axvline(level,linestyle='dashed',color='gray')
        if level<0:
            j=j+1
            plt.text(middle-0.01, ymax+0.01, str(j))            
        else:
            plt.text(middle-0.01, ymax+0.01, str(j))
            j=j-1

    levels.append(xmax)
    plt.axvline(xmax,linestyle='dashed',color='gray')       
    plt.figure(1)
    # plt.savefig(directory+'/plots/'+filename.replace('txt','png') ,bbox_inches='tight')
    
    root_vessels=[d[:-2] for d in result.split('\n') if d.count(',')==2]
    root_vessels.sort()
    root_vessels=set(root_vessels)
    root_nodes=[n.split(':')[0] for n in root_vessels]
    # plt.text((levels[0]+levels[1])/2,0,root_nodes[0])
    # plt.text((levels[-2]+levels[-1])/2,0,root_nodes[-1])

    # plt.text((levels[1]+levels[2])/2,0,root_nodes[0])
    # plt.text((levels[-3]+levels[-2])/2,0,root_nodes[-1])
    
import matplotlib
matplotlib.rcParams.update({'font.size': 20})
   
directory='/home/shahrzad/repos/VascularModelingData/'
filename='SimpleVesselGeneratorlog_2_3_2.txt'
f=open(filename, 'r')
             
result=f.read()


nodes={}
connected_vessels={}
colors=['r', 'b', 'g','c' ,'m', 'y', 'lime', 'orange','dimgray','peru']
i=0
all_vessels=[d for d in result.split('\n') if d.count(',')>4]
plot_general(all_vessels)
       
for i in range(len(subnetworks)):
    sb=subnetworks[i]
    nodes[i]={}
    connected_vessels[i]={}
    arteries=sb.split('arteries\n')[1].split('Veins\n')[0].split('\n\n')[:-1]
    veins=sb.split('Veins\n')[1].split('\n\n')[:-1]
    # plot_network(arteries,i,nodes,connected_vessels)
    # plot_network(veins,i,nodes,connected_vessels)
    
    