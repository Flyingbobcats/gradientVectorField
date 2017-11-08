
clc
clear
close all

uav = UAV;
uav.x = -10;
uav.y = 0;
uav.vx = 1;
uav.vy = 0;
uav.v = 1;
uav.heading = 0;



env = vectorField;
env = env.newvf('circ');

figure
env.pltff;
axis equal
hold on

for t = 1:1000
   
    [u,v] = env.avf{1}.comp(uav.x,uav.y);
    heading = atan2(v,u);
    uav = uav.update_pos(heading);
    
    
    plot(uav.x,uav.y,'r.');
    drawnow
    
    
    
end