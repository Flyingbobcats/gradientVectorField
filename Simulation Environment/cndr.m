%Simnple cylinder and plane VF with decayivation functions
classdef cndr
    properties
        active = true
        normComponents = true
        
        %Cylinder properties
        x = 0;
        y = 0;
        r = 3;
        e  =0.5;
        
        const
        %Plane Properties
        z = 1;
        
        %Space properties
        n = 25;
        xspace = linspace(-10,10,50);
        yspace = linspace(-10,10,50);
        
        %Define the surfaces
        a1 = @(x,y,r) x^2+y^2-r^2;
        a2 = @(z) z;
        
        %Define the gradiants of the surfaces
        g1 = @(x,y) [2*x;2*y;0];
        g2 = @() [0;0;1];
        
        
        %Activation Functions
        H = 1
        G = 1
        
        type = 'const'
        
        %Decay Function
        decay = @(r) 1;
        ext = 1;
    end
    
    
    
    methods
        
        
        function [u,v] = comp(self,posx,posy)
            
            range = sqrt((self.x-posx)^2+(self.y-posy)^2);
            [self.G,self.H] = getGH(self,range);
            
            
            Vconv = ((self.a1(posx-self.x,posy-self.y,self.r)*self.g1(posx-self.x,posy-self.y)) + self.a2(self.z)*self.g2());
            Vcirc = (cross(self.g1(posx-self.x,posy-self.y),self.g2()));
            
            if self.normComponents == true
                VcircNorm = norm(Vcirc);
                VconvNorm = norm(Vconv);
                Vt = -self.G*Vconv/VconvNorm+self.H*Vcirc/VcircNorm;
            else
                Vt = -self.G*Vconv+self.H*Vcirc;
            end
            
            %             range = sqrt((self.x-posx)^2+(self.y-posy)^2);
            mag = norm(Vt);
            u =   self.decay(range)*Vt(1)/mag;
            v =   self.decay(range)*Vt(2)/mag;
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
                    U(i,j) =  vec(1);
                    V(i,j) =  vec(2);
                    X(i,j) = self.xspace(i);
                    Y(i,j) = self.yspace(j);
                end
            end
        end
        
        
        
        
        % ===================== Activation and Decay Functions ===================
        
        
        function [G,H] = getGH(self,range)

               G = self.G;
               H = self.H;


%             if strcmp(self.type,'channel')
%                 if range > self.r+self.e %|| range < self.r-self.e
%                     G = 1;
%                     H = 1;
%                 elseif range < self.r-self.e
%                     H = 0;
%                     G = self.G;
%                 else
%                     G = 0.5/range;
%                     H = 1;
%                 end
%             end
%             if strcmp(self.type,'const')
%                 G = 1;
%                 H = 0;
%             end
        end
        
        function self = modDecay(self,type)
            if strcmp(type,'none') == 1
                self.decay = @(r) 1;
            end
            
            if strcmp(type,'hyper') == 1
                self.decay = @(r) (1+tanh(-3.5*r/10));
            end
            
        end
        
        
        % ====================== Plotting Functions ==============================%
        function pltfnc(self)
            theta = 0:0.01:2*pi;
            cxs = self.x+self.r*cos(theta);
            cys = self.y+self.r*sin(theta);
            plot(cxs,cys,'r','linewidth',2);
        end
        
        
        function pltDecay(self)
            theta = 0:0.05:2*pi;
            cxs = self.x+5*cos(theta);
            cys = self.y+5*sin(theta);
            plot(cxs,cys,'r--','linewidth',3);
        end
        
    end
end
