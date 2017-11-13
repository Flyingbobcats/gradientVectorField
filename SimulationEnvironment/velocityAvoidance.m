%Demonstrate the impact of velocity on obstacle avoidance in a gradient
%vector field of constant weight


clc
clear
close all
F = figure;
hold on
%Initialize the vector field
vf = vectorField;
vf = vf.xydomain(35,0,0,125);

%Generate a straight line path to follow
vf = vf.navf('line');
vf.avf{1}.angle = pi/2;

%Place a circulat obstacle centered on the path
vf = vf.nrvf('circ');
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.H = 0;
vf.rvf{1}.r = 0.1;
vf.rvfWeight = 50;



vf.pltff
vf.rvf{1}.pltDecay





Velocities = [1,2,3,4,5];

for i=1:length(Velocities)
%Setup UAV
uav = UAV;
uav.x = -10;
uav.y = 0;
uav.vx = Velocities(i);
uav.vy = 0;
uav.v = Velocities(i);
uav.heading = 0;
uav.pltQuiver = false;





while uav.x<35
   [u,v] = vf.heading(uav);
   cmd_heading = atan2(v,u);
   uav = uav.update_pos(cmd_heading);
   uav.pltUAV;
   drawnow
end
end

axis([-15,35,-10,10]);
xlabel('East');
ylabel('North');
title(' No Circulation');




