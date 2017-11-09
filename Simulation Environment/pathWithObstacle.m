
clc
clear
close all


vs = [1,2,3,4];

for i = 1:length(vs)
F(i) = figure;
hold on
vf = vectorField;
vf = vf.navf('line');
vf = vf.xydomain(50,0,0,100);
vf.avf{1}.G = 1;
vf.avf{1}.theta = pi/2;


vf = vf.nrvf('circ');
vf.rvf{1}.r = 0.1;
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.H = 1;

subplot(2,1,1);
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
        
        
        
        if mod(i,1) == 0
            subplot(2,1,1);
%             quiver(uav.x,uav.y,uav.vx,uav.vy,'r','linewidth',2,'autoscale','on','maxheadsize',2);
%             quiver(uav.x,uav.y,u,v,'b','linewidth',2,'autoscale','on','maxheadsize',2);
              hold on
              plot(uav.x,uav.y,'k.');
            
            subplot(2,1,2);
            plot(uav.ts,uav.headings,'r',uav.ts,uav.headingcmds,'b');
      
            drawnow
        end

        
        
        
    end
end


