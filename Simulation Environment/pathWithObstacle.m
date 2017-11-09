
clc
clear
close all



hold on
hs = [0,5];
for i=1:2
vf = vectorField;
vf = vf.navf('line');
vf = vf.xydomain(50,0,0,200);
vf.avf{1}.G = 1;
vf.avf{1}.theta = pi/2;


vf = vf.nrvf('circ');
vf.rvf{1}.r = 0.1;
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.H = hs(i)


vf.rvf{1}.pltfnc
vf.rvf{1}.pltDecay
vf.pltff
axis equal

uav = UAV;
uav.x = -10;
uav.y = 0;
uav.vx = 1;
uav.vy = 0;
uav.heading = 0;
    
    
    
    while uav.x<40
        
        
        [u,v] = vf.heading(uav);
        heading = atan2(v,u);
        uav = uav.update_pos(heading);
        
        
        plot(uav.x,uav.y,'r.')
        drawnow
        
        
        
    end
end

