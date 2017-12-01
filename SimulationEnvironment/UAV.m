classdef UAV

    properties
        useDubins = true
        pltQuiver = true
        colorMarker = 'k.';
        quiverColor = 'r';
        
        v = 1;
        dt = 0.1;
        t = 0;
        
        turnrate = 0.35;
        
        %Current state
        x = [];
        y = [];    
        vx = [];
        vy = [];
        heading = [];
        
        %History
        xs = [];
        ys = [];
        vxs = [];
        vys = [];
        headings = [];
        headingcmds = [];
        ts = [];
    end
    
    methods
        
        function self =  update_pos(self,vf) 
            if self.useDubins == true
                theta = atan2(self.vy,self.vx);
                if abs(theta - vf) < pi
                    if theta - vf < 0
                        theta = theta + self.turnrate*self.dt;
                    else
                        theta = theta - self.turnrate*self.dt;
                    end
                else
                    if theta - vf > 0
                        theta = theta + self.turnrate*self.dt;
                    else
                        theta = theta - self.turnrate*self.dt;
                    end
                end
            else
                theta = vf;
            end
            
           
            %Update Velocity and Position
            self.vx = self.v*cos(theta);
            self.vy = self.v*sin(theta);
            
            self.x = self.x+self.vx*self.dt;
            self.y = self.y+self.vy*self.dt;
            
            %Update History
            self.xs(end+1) = self.x;
            self.ys(end+1) = self.y;
            self.heading = theta;
            self.vxs(end+1) = self.vx;
            self.vys(end+1) = self.vy;
            self.headings(end+1) = theta;
            self.headingcmds(end+1) = vf;
            self.t=self.t+self.dt;
            self.ts(end+1)=self.t;
        end
        
         
        function self = setup(x0,y0,v,theta)  
            theta = deg2rad(theta);
            self.x = x0;
            self.y = y0;
            self.v = v;
            self.heading = theta;
            self.vx = v*cos(theta);
            self.vy = v*sin(theta);
            
            
        end
        function pltUAV(self)
            
            plot(self.x,self.y,self.colorMarker);
            
            if self.pltQuiver
                U = cos(self.heading);
                V = sin(self.heading);
                quiver(self.x,self.y,U,V,self.quiverColor,'linewidth',2,'maxHeadSize',10);
            end
            
        end
            
            
        
        
        
    end
    
end

