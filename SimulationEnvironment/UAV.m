classdef UAV

    properties
        useDubins = true
        heading_rate_max = 0.1;
        v = 1;
        dt = 0.1;
        t = 0;
        
        turnrate = 0.3;
        
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
            self.vxs(end+1) = self.vx;
            self.vys(end+1) = self.vy;
            self.headings(end+1) = theta;
            self.headingcmds(end+1) = vf;
            self.t=self.t+self.dt;
            self.ts(end+1)=self.t;
        end
        
         
    end
    
end

