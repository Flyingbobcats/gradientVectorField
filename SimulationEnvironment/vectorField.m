%Main vector field object to store, create, and modify multiple vector
%fields

classdef vectorField


    
    properties
        avf = {};
        rvf = {};
        
        
        %Global properties
        xspace = linspace(-10,10,50);
        yspace = linspace(-10,10,50);
        n = 25;
    end
    
    methods
        
        %Add a vector field
        function self = navf(self,type)
            if strcmp(type,'circ')==1
            self.avf{length(self.avf)+1} = cndr;
            end
            
            if strcmp(type,'line')
                self.avf{length(self.avf)+1} = gvfLine;
            end
            %Give new field default settings
            self.avf{end}.xspace = self.xspace;
            self.avf{end}.yspace = self.yspace;
        end
        
        function self = nrvf(self,type)
            if strcmp(type,'circ')==1
                self.rvf{length(self.rvf)+1} = cndr;
                self.rvf{end}.G = -5;
                self.rvf{end}.H = 0;
            end
            
            if strcmp(type,'line')
                self.rvf{length(self.rvf)+1} = gvfLine;
            end
            %Give new field default settings
            self.rvf{end}.xspace = self.xspace;
            self.rvf{end}.yspace = self.yspace;
        end
        
        
        %Change the x and y doman
        function self = xydomain(self,s,x_c,y_c,n_new)
            x_space_new = linspace(-s+x_c,s+x_c,n_new);
            y_space_new = linspace(-s+y_c,s+y_c,n_new);
            self.xspace = x_space_new;
            self.yspace = y_space_new;
            self.n = n_new;
            
            for i = 1:length(self.avf)
               self.avf{i}.xspace = x_space_new;
               self.avf{i}.yspace = y_space_new;
               self.avf{i}.n = n_new;
            end
            
            for i = 1:length(self.rvf)
                self.rvf{i}.xspace = x_space_new;
                self.rvf{i}.yspace = y_space_new;
                self.rvf{i}.n = n_new;
            end
                      
        end

        function heading = getHeading(self,xs,ys)
            for i = 1:length(self.avf)
                [U,V] = self.avf{i}.comp(xs,ys);
                Ut(i) = U;
                Vt(i) = V;
            end
            Ut = sum(Ut);
            Vt = sum(Vt);
            heading = atan2(Vt,Ut);
        end
         
       
        function [X,Y,Ut,Vt] = sumFields(self)
            
            if length(self.avf) + length(self.rvf) < 1
                warning('No vector fields to sum');
                X = NaN;
                Y = NaN;
                Uta = NaN;
                Vta = NaN;
                return
            end
            
            %Attractive Vector Fields
            Usa = cell(length(self.avf));
            Vsa = cell(length(self.avf));
            for i = 1:length(self.avf)
                if self.avf{i}.active == true
                [X,Y,U,V] = self.avf{i}.ff;
                Usa{i} = U;
                Vsa{i} = V;
                end
            end
            
            %Repulsive Vector Fields
            Usr = cell(length(self.rvf));
            Vsr = cell(length(self.rvf));
            for i = 1:length(self.rvf)
                if self.rvf{i}.active == true
                    [X,Y,U,V] = self.rvf{i}.ff;
                    Usr{i} = U;
                    Vsr{i} = V;
                end
            end
            
            Uta = zeros(length(self.xspace));
            Vta = zeros(length(self.yspace));
            for i = 1:length(Usa)
               for j = 1:length(Usa{1})
                    for k = 1:length(Usa{1})
                    Uta(j,k) = Uta(j,k)+Usa{i}(j,k);
                    Vta(j,k) = Vta(j,k)+Vsa{i}(j,k);
                    end
               end
            end
            
            Utr = zeros(length(self.xspace));
            Vtr = zeros(length(self.yspace));
            for i = 1:length(Usr)
               for j = 1:length(Usr{1})
                    for k = 1:length(Usr{1})
                    Utr(j,k) = Utr(j,k)+Usr{i}(j,k);
                    Vtr(j,k) = Vtr(j,k)+Vsr{i}(j,k);
                    end
               end
            end
            
            for i = 1:length(self.xspace)
                for j = 1:length(self.yspace)
                    
                    Ut(i,j) = Uta(i,j)+50*Utr(i,j);
                    Vt(i,j) = Vta(i,j)+50*Vtr(i,j);
                    
                    N = sqrt((Ut(i,j))^2+(Vt(i,j))^2);
                    Ut(i,j) = Ut(i,j)/N;
                    Vt(i,j) = Vt(i,j)/N;
                end
            end
        end
        
        
        
        
        function [Ut,Vt] = heading(self,uav)
            
            posx = uav.x;
            posy = uav.y;
            
            Usa = cell(length(self.avf));
            Vsa = cell(length(self.avf));
            for i = 1:length(self.avf)
                if self.avf{i}.active == true
                [U,V] = self.avf{i}.comp(posx,posy);
                Usa{i} = U;
                Vsa{i} = V;
                end
            end
            
            %Repulsive Vector Fields
            Usr = cell(length(self.rvf));
            Vsr = cell(length(self.rvf));
            for i = 1:length(self.rvf)
                if self.rvf{i}.active == true
                    [U,V] = self.rvf{i}.comp(posx,posy);
                    Usr{i} = U;
                    Vsr{i} = V;
                end
            end
            
            Uta = zeros(1);
            Vta = zeros(1);
            for i = 1:length(Usa)
               for j = 1:length(Usa{1})
                    for k = 1:length(Usa{1})
                    Uta(j,k) = Uta(j,k)+Usa{i}(j,k);
                    Vta(j,k) = Vta(j,k)+Vsa{i}(j,k);
                    end
               end
            end
            
            Utr = zeros(1);
            Vtr = zeros(1);
            for i = 1:length(Usr)
               for j = 1:length(Usr{1})
                    for k = 1:length(Usr{1})
                    Utr(j,k) = Utr(j,k)+Usr{i}(j,k);
                    Vtr(j,k) = Vtr(j,k)+Vsr{i}(j,k);
                    end
               end
            end
            
            for i = 1:length(1)
                for j = 1:length(1)
                    Ut(i,j) = Uta(i,j)+50*Utr(i,j);
                    Vt(i,j) = Vta(i,j)+50*Vtr(i,j);
                end
            end
        end
         

%=================== Plotting ====================================%
        function pltff(self)
            [x,y,u,v] = self.sumFields;
            quiver(x,y,u,v);
            axis equal
        end
        function pltPaths(self) 
           for i = 1:length(self.avf)
              self.avf{i}.pltfnc; 
           end
        end        
%%%% ============= Helper / Debugger Functions ======================
        %Number of vector fields
        function numvf(self)
            length(self.avf)
        end
        
        
        
    end
    
end

