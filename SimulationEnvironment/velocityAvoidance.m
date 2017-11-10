%Demonstrate the impact of velocity on obstacle avoidance in a gradient
%vector field of constant weight


clc
clear
close all

%Initialize the vector field
vf = vectorField;
vf = vf.xydomain(50,0,0,100);

%Generate a straight line path to follow
vf = vf.navf('line');
vf.avf{1}.angle = pi/2;

%Place a circulat obstacle centered on the path
vf = vf.nrvf('circ');
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.r = 0.1;
vf.pltff
hold on
vf.rvf{1}.pltDecay
vf.rvf{1}.H = 10;


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





while uav.x<20
   [u,v] = vf.heading(uav);
   cmd_heading = atan2(v,u);
   uav = uav.update_pos(cmd_heading);
   uav.pltUAV;
   drawnow
end
end

axis([-20,20,-15,15]);
axis equal



