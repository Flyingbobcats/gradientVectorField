% Loitering avoidance


clc
clear
close all

pathxy = [0,0;10,0;10,10;20,10];

vf = vectorField;
vf = vf.navf('circ');
vf.avf{1}.H = -1;
vf.avf{1}.G = 1;
vf.avf{1}.r = 2;
vf.rvfWeight =2;


vf = vf.xydomain(50,0,0,25);

vf = vf.nrvf('circ');
vf.rvf{1}.L = 0;
vf.rvf{2}.L = 0;
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.r = 0.01;
vf.rvf{1}.decayR = 15;
vf.rvf{1}.x = 0;
vf.rvf{1}.y = 25;

vf = vf.nrvf('circ');
vf.rvf{2} = vf.rvf{1}.modDecay('hyper');
vf.rvf{2}.r = 0.01;
vf.rvf{2}.decayR = 15;
vf.rvf{2}.x = 30;
vf.rvf{2}.y = 10;

% vf.rvf{1}.active = false;
% vf.rvf{1}.active = false;



V = 0.7;
t = 0;
dt = 0.1;

uav = UAV;
uav.dt = dt;
uav.useDubins = true;

uav.x = -20;
uav.y = 0;
uav.v = 0.7;
uav.vx = 0.7;
uav.vy = 0;
uav.heading = 0;
while t < 300
    
    theta = zigZag(t/0.14);

    v = 1/5*0.7*dt;
    vf.avf{1}.x = vf.avf{1}.x+v*cos(theta);
    vf.avf{1}.y = vf.avf{1}.y+v*sin(theta);
    vf.avf{1}.vx = v*cos(theta);
    vf.avf{1}.vy = v*sin(theta);

    
    [u,v] = vf.heading(uav);
    head = atan2(v,u);
    uav =  uav.update_pos(head);
    
    
    

    clf
    hold on
%     vf.pltff
    plot(pathxy(:,1),pathxy(:,2),'k','linewidth',2);
    quiver(uav.x,uav.y,u,v,'b');
    plot(uav.xs,uav.ys,'k.');
%     axis([-50,50,-50,50]);
    vf.avf{1}.pltfnc
    vf.rvf{1}.pltDecay
    vf.rvf{2}.pltDecay
     axis equal
    uav.pltUAV;
     drawnow

   t = t+dt
end

hold on
 plot(pathxy(:,1),pathxy(:,2),'k','linewidth',2);
     plot(uav.xs,uav.ys,'k.');
      vf.avf{1}.pltfnc
    vf.rvf{1}.pltDecay
    vf.rvf{2}.pltDecay
    axis equal





