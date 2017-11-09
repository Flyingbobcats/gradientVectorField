
clc
clear
close all



vs = [1,2,3,4,5,6];

for i = 1:length(vs)
F(i) = figure;
hold on
vf = vectorField;
vf = vf.navf('line');
vf = vf.xydomain(25,0,0,100);
vf.avf{1}.G = 1;
vf.avf{1}.theta = pi/2;


vf = vf.nrvf('circ');
vf.rvf{1}.r = 0.1;
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.H = 1;


hold on
vf.rvf{1}.pltfnc
vf.rvf{1}.pltDecay
vf.pltff
axis equal

uav = UAV;
uav.x = -10;
uav.y = 0;
uav.vx = vs(i);
uav.vy = 0;
uav.v = vs(i);
uav.heading = 0;
    
i = 0;
    
    while uav.x<10
        
        i = i+1;
        [u,v] = vf.heading(uav);
        heading = atan2(v,u);
        uav = uav.update_pos(heading);
        
       
        if mod(i,10) == 0
            uav.pltUAV
            axis([-20,20,-10,10]);
            drawnow
        end

        
        
        
    end
end


