
clc
clear
close all


vf = vectorField;

vf = vf.nrvf('circ');
% vf = vf.nrvf('circ');
% vf = vf.nrvf('circ');

vf.rvf{1}.r = 0.01;
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
% vf.rvf{2}.decayR = 5;



% vf.rvf{1}.x = 0;
% vf.rvf{2}.x = 20;
% vf.rvf{3}.x = 10;
% vf.rvf{3}.y = -10;


% hold on
% vf.rvf{1}.pltff;
% vf.rvf{2}.pltff;
% vf.rvf{3}.pltff;
% axis equal

rs = 1:1:25;

for i=1:length(rs)
    
    
    clf
    hold on
    vf.rvf{1}.decayR = rs(i);
    vf.rvf{1}.pltff;
    vf.rvf{1}.pltDecay
    axis([-30,30,-30,30]);
    axis equal
    
    vf.rvf{1}.decayR
 
    pause()
    
    
end