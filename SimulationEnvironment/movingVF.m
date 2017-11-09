
clc
clear
close all

theta = 0:0.1:10*pi;


xs = 5*cos(theta);
ys = 5*sin(theta);


% xs = -35:0.1:35;
% ys = -5;


vecField = vectorField;
vecField = vecField.newvf('circ');
vecField.avf{1}.H = 10;
vecField = vecField.xydomain(25,0,0,35);
[X,Y,Ut,Vt] = vecField.sumFields;

clf
hold on
quiver(X,Y,Ut,Vt);

axis([-20,20,-20,20]);
axis equal
drawnow


s = uav;
s.x = 1;
s.y = 1;
s.heading = deg2rad(270);

for i = 1:length(xs)
    
    
    
end

