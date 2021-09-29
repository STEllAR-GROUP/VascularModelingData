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

def plot_general(filename):
    f=open(filename, 'r')
                 
    result=f.read()
    
    all_vessels=[d for d in result.split('\n') if d.count(': ')>=1 and d.count('\t')>=4]
    
    middles=[]
    levels=[]
    ymax=0
    xmax=0
    vessel_info={}
    nodes={}  
    connected_nodes={}
    for (ves) in all_vessels:
        global_id=ves.split(': ')[0]    
        vessel_info[global_id]={'node_ids':[],'connected_vessels_labels':[]}
        rank=int(ves.split(': ')[0].split(',')[0])
        points=ves.split(': ')[1].split('\t')[0:2]        
        [p1,p2]=points       
        node_indices=ves.split(': ')[1].split('\n')[0].split('\t')[3:]
        if node_indices[0] not in connected_nodes.keys():
            connected_nodes[node_indices[0]]=[]
        if node_indices[1] not in connected_nodes.keys():
            connected_nodes[node_indices[1]]=[]
        
        connected_nodes[node_indices[0]].append(node_indices[1])
        connected_nodes[node_indices[1]].append(node_indices[0])
        vessel_info[global_id]['node_ids']=node_indices
        x1,y1,_=p1.split(',')
        x2,y2,_=p2.split(',')
        x1=float(x1)
        x2=float(x2)
        y1=float(y1)
        y2=float(y2)
        middle=(x1+x2)/2

        plt.figure(1)
        plt.axes([0, 0, 3, 3])
        
        if node_indices[0] not in nodes.keys():
            nodes[node_indices[0]]=[x1,y1]
        if node_indices[1] not in nodes.keys():
            nodes[node_indices[1]]=[x2,y2]
        
        if not ',' in ves.split(': ')[0]:
            plt.plot([x1,x2], [y1,y2],color='gray',marker='o')
        else:
            plt.plot([x1,x2], [y1,y2],color=colors[rank],marker='o')
        plt.text(x1,y1,node_indices[0])
        plt.text(x2,y2,node_indices[1])
        ymax=max(y1,y2,ymax)
        xmax=max(x1,x2,xmax)


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
    plt.savefig(filename.replace('.txt','.png') ,bbox_inches='tight')

      
def plot_general_with_labels(filename):
    f=open(filename, 'r')
                 
    result=f.read()
    all_vessels=[]
    for d in result.split('\n\n'):
        temp=[]
        if d.count(': ')>=2 and d.count(',')>=2:
            for dd in d.split('\n'):
                if dd.count(': ')>=1 and dd.count(',')>=1 and dd not in temp:
                    temp.append(dd)
            all_vessels.append(temp)
    
        
    # all_vessels=[d.split('\n')[-2:] for d in result.split('\n\n') if d.count(': ')>=2]
    
    
    middles=[]
    levels=[]
    ymax=0
    xmax=0
    vessel_info={}
    nodes={}  
    connected_nodes={}
    vessel_labels={}
    for (ves,connection) in all_vessels:
        global_id=ves.split(': ')[0]    
        vessel_info[global_id]={'node_ids':[],'connected_vessels_labels':[]}
        rank=int(ves.split(': ')[0].split(',')[0])
        points=ves.split(': ')[1].split('\t')[0:2]        
        [p1,p2]=points       
        node_indices=ves.split(': ')[1].split('\n')[0].split('\t')[3:]
        if node_indices[0] not in connected_nodes.keys():
            connected_nodes[node_indices[0]]=[]
        if node_indices[1] not in connected_nodes.keys():
            connected_nodes[node_indices[1]]=[]
        
        if node_indices[1] not in connected_nodes[node_indices[0]]:
            connected_nodes[node_indices[0]].append(node_indices[1])
        if node_indices[0] not in connected_nodes[node_indices[1]]:
            connected_nodes[node_indices[1]].append(node_indices[0])    
        vessel_info[global_id]['node_ids']=node_indices
        vessel_info[global_id]['connected_vessels_labels']=connection.split(': ')[1].split(', ')[:-1]
        x1,y1,_=p1.split(',')
        x2,y2,_=p2.split(',')
        x1=float(x1)
        x2=float(x2)
        y1=float(y1)
        y2=float(y2)
        middle=(x1+x2)/2

        plt.figure(1)
        plt.axes([0, 0, 3, 3])
        
        if node_indices[0] not in nodes.keys():
            nodes[node_indices[0]]=[x1,y1]
        if node_indices[1] not in nodes.keys():
            nodes[node_indices[1]]=[x2,y2]
        
        if not ',' in ves.split(': ')[0]:
            plt.plot([x1,x2], [y1,y2],color='gray',marker='o')
            vessel_labels[global_id]=connection.split(': ')[0]
        else:
            plt.plot([x1,x2], [y1,y2],color=colors[rank],marker='o')
        plt.text(x1,y1,node_indices[0])
        plt.text(x2,y2,node_indices[1])
        ymax=max(y1,y2,ymax)
        xmax=max(x1,x2,xmax)


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

    for ves in vessel_info.keys():
        c_nodes=[]
        
        if nodes[vessel_info[ves]['node_ids'][0]][0]>=0:
            for n in connected_nodes[vessel_info[ves]['node_ids'][1]]:
                if n not in c_nodes and n not in vessel_info[ves]['node_ids']:
                    c_nodes.append(int(n))
            c_nodes.sort(reverse=True)
            ves_type='vein'            
            start=vessel_info[ves]['node_ids'][1]
            for vid,end in zip(vessel_info[ves]['connected_vessels_labels'][0:len(c_nodes)],c_nodes):
                end=str(end)
                print(ves,vid)

                middle_x=(nodes[start][0]+nodes[end][0])/2
                middle_y=(nodes[start][1]+nodes[end][1])/2
                plt.figure(1)
                
        else:
            ves_type='artery'
            if vessel_info[ves]['node_ids'][0]=='0':
                plt.text((nodes[vessel_info[ves]['node_ids'][0]][0]+nodes[vessel_info[ves]['node_ids'][1]][0])/2,0,'0',color='gray')
            start=vessel_info[ves]['node_ids'][1]
            c_nodes=[n for n in connected_nodes[vessel_info[ves]['node_ids'][1]] if n!=vessel_info[ves]['node_ids'][0]]
            for vid,end in zip(vessel_info[ves]['connected_vessels_labels'][-len(c_nodes):],c_nodes):
                middle_x=(nodes[start][0]+nodes[end][0])/2
                middle_y=(nodes[start][1]+nodes[end][1])/2
                plt.figure(1)
                plt.text(middle_x,middle_y,vid,color='gray')

    plt.figure(1)
    plt.savefig(filename.replace('.txt','_labels.png') ,bbox_inches='tight')
 
    
import matplotlib
matplotlib.rcParams.update({'font.size': 20})
   




colors=['r', 'b', 'g','c' ,'m', 'y', 'lime', 'orange','dimgray','peru']
directory='/home/shahrzad/repos/VascularModelingData/'
data_dir='2_3_2'
filename=directory+'data/gcc/'+data_dir+'/SimpleVesselGeneratorlog_'+data_dir+'.txt'
plot_general(filename)
plot_general_with_labels(filename)

       
# for i in range(len(subnetworks)):
#     sb=subnetworks[i]
#     nodes[i]={}
#     connected_vessels[i]={}
#     arteries=sb.split('arteries\n')[1].split('Veins\n')[0].split('\n\n')[:-1]
#     veins=sb.split('Veins\n')[1].split('\n\n')[:-1]
#     # plot_network(arteries,i,nodes,connected_vessels)
#     # plot_network(veins,i,nodes,connected_vessels)
    
    