
clc
clear
close all

vf  = vectorField;

vf = vf.nrvf('circ');
vf.rvf{1}.type = 'channel';
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');

vf = vf.navf('line');
vf.avf{1}.theta = pi/2;

vf.pltff


uav = UAV;
uav.x = -10;
uav.y = 0;
uav.v = 1;
uav.vx = 1;
uav.vy=0;
uav.heading = 0;

hold on
while uav.x<20
    [u,v] = vf.heading(uav);
    heading = atan2(v,u);
    
    if uav.x > 0
        vf.rvf{1}.H = 1;
        vf.rvf{1}.G = -1;
        vf.rvf{1}.r = 0.1;
        vf.rvf{1}.type = 'const';
    end
    
    
    uav = uav.update_pos(heading);
    
    clf
    hold on
    vf.pltff
    uav.pltUAV
    axis([-20,20,-10,10]);
    drawnow
end