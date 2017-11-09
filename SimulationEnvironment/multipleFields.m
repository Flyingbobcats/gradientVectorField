%several vf

clc
clear
close all

env = vectorField;

fields = 1;

env = env.xydomain(20,0,0,100);

env = env.newvf('circ');
env.avf{1}.G = -1;
env.avf{1}.H = 0;
env.avf{1}.r = 0.1;

  
    


hold on
env.pltff
env.pltPaths
env.avf{1}.pltDecay
axis equal