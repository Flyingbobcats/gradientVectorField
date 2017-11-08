classdef UAV

    properties
        useDubins = true
        
        x = [];
        y = [];
        
        vx = [];
        vy = [];
        heading = [];
        
        heading_rate_max = 0.1;
        
        v = 1;
        dt = 0.1;
        turnrate = 0.3;
    end
    
    methods
        
        function self =  update_pos(self,vf)
            
            theta = atan2(self.vy,self.vx);
            if self.useDubins == true
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
            end
            
            %Update Velocity and Position
            self.vx = self.v*cos(theta);
            self.vy = self.v*sin(theta);
            
            self.x = self.x+self.vx*self.dt;
            self.y = self.y+self.vy*self.dt;
        end
        
         
    end
    
end

