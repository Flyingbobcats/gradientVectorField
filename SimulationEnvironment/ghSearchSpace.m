%Explore G and H combinations and their effect on total distance

clc
clear
close all

Hs = linspace(-10,10,100);
Gs = linspace(-1,-10,100);

COSTS = {};

for j = 1:length(Hs)
    parfor k = 1:length(Gs)
        
        vf = vectorField;
        vf = vf.navf('line');
        vf.avf{1}.theta = pi/2;
        
        vf = vf.nrvf('circ');
        vf.rvf{1}.r = 0.1;
        vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
        vf.rvf{1}.H = Hs(j);
        vf.rvf{1}.G = Gs(k);
        
        vf.rvf{1}.active = true;
        
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
            uav = uav.update_pos(heading);
            %     uav.pltUAV
            %     axis([-20,20,-10,10]);
            %     drawnow
        end
        
        
        cost = 0;
        for i=2:length(uav.xs)
            cost = cost+sqrt((uav.xs(i)-uav.xs(i-1))^2+(uav.ys(i)-uav.ys(i-1))^2);
        end
        COSTS{j,k} = cost;
    end
end

%Find combination of G and H that resulted in minimum cost and resimulate
c = cell2mat(COSTS);
[minCost, index] = min(c(:));
[row,column] = ind2sub(size(c),index);


vf = vectorField;
vf = vf.navf('line');
vf.avf{1}.theta = pi/2;

vf = vf.nrvf('circ');
vf.rvf{1}.r = 0.1;
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.H = Hs(row);
vf.rvf{1}.G = Gs(column);
vf.rvf{1}.active = true;

vf.pltff
vf.rvf{1}.pltDecay

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
    uav = uav.update_pos(heading);
        uav.pltUAV
        axis([-20,20,-10,10]);
        drawnow
end
















