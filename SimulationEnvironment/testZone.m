
clc
clear
close all


vf = vectorField;
vf = vf.newvf('line');


THETAS = linspace(0,10*pi,200);
XS = linspace(-10,10,100);
XS = [XS,linspace(10,-10,100)];

YS = linspace(-10,10,100);
YS = [YS,linspace(10,-10,100)];


figure
for i=1:length(XS)
     vf.avf{1}.x = XS(i);
     vf.avf{1}.theta = THETAS(i);
    vf.pltff;
    axis([-15,15,-15,15]);
    pause(0.01);
    
end

