%Arbitrary line


classdef xycurve   
    properties
        active = true
        
        
        %Cylinder properties
        x = 0;
        y = 0;
        r = 3;
        
   
        vx = 0;
        vy = 0;
        
        %Plane Properties
        z = 1;
        
        %Weights
        G = 1;
        H = 1;
        
        %Space properties
        n = 25;
        xspace = linspace(-10,10,25);
        yspace = linspace(-10,10,25);
        
        %Define the surfaces
        theta = 0
        a1 = @(x,y,r) 0*x+0.5*y;
        a2 = @(z) z;
        
        %Define the gradiants of the surfaces
        g1 = @(x,y) [0*0.5;1;0];
        g2 = @() [0;0;1];
        
        %Activation Function
        act = 1;
        ext = 1;
    end
    

    
    methods 
        
        function beta = head(self,posx,posy) %Generate heading for single point

             vec = -self.G*((self.a1(posx,posy,self.r)*self.g1(posx,posy)) + self.a2(self.z)*self.g2()) + self.H*(cross(self.g1(posx,posy),self.g2()));
%              out = [vec(1)/mag;vec(2)/mag;vec(3)/mag];

            beta = atan2(vec(2),vec(1));
             
        end
        
        function [u,v] = comp(self,posx,posy)
            vec = -self.G*((self.a1(posx-self.x,posy-self.y,self.r)*self.g1(posx-self.x,posy-self.y)) + self.a2(self.z)*self.g2()) + self.H*(cross(self.g1(posx-self.x,posy-self.y),self.g2()));
            mag = sqrt(vec(1)^2+vec(2)^2);
            u = vec(1)/mag;
            v = vec(2)/mag;
        end
      
        
        function [X,Y,U,V] = ff(self) %Output entire vector field
            U = NaN(length(self.xspace),length(self.yspace));
            V = NaN(length(self.xspace),length(self.yspace));
            X = NaN(length(self.xspace),length(self.yspace));
            Y = NaN(length(self.xspace),length(self.yspace));
            for i = 1:length(self.xspace)
                for j = 1:length(self.yspace)
                    [u,v] = comp(self,self.xspace(i),self.yspace(j));
                    vec = [u,v];
                    mag = sqrt(vec(1)^2+vec(2)^2);
                    R = sqrt((self.xspace(i)-self.x)^2+(self.yspace(j)-self.y)^2);
                    U(i,j) =  vec(1)/mag;
                    V(i,j) =  vec(2)/mag;
                    X(i,j) = self.xspace(i);
                    Y(i,j) = self.yspace(j);
                end
            end
        end
        
        
        
        % = = = = = = = =  Activation Functions = = = = = = = = = %
        
        function  obj = modact(obj,arg)
           switch arg
               case 'on'
                   obj.act = 1;
                   
               case 'off'
                   obj.act = 2;
                   
               case 'hyper'
                   obj.act = 3;
           end

        end
        

        
        % = = = = = = = = Plotting Functions = = = = = = = = = =  %
        function pltr(self)
           [X,Y,u,v] = self.ff;
            quiver(X,Y,u,v,'r')
            axis equal
        end
        
          function pltb(self)
           [X,Y,u,v] = self.ff;
            quiver(X,Y,u,v,'b')
            axis equal
        end
        
        function pltfnc(self)
           theta = 0:0.01:2*pi;
           cxs = self.x+self.r*cos(theta);
           cys = self.y+self.r*sin(theta);
           plot(cxs,cys,'r','linewidth',2);
        end
        
        function pltcndr(self)
           
            theta = 0:0.05:2.1*pi;
            cxs = self.x+self.r*cos(theta);
            cys = self.y+self.r*sin(theta);
            plot(cxs,cys,'r','linewidth',3);
        end
        
        
    end
end
