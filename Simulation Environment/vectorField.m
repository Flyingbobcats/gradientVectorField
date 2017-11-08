%Main vector field object to store, create, and modify multiple vector
%fields

classdef vectorField


    
    properties
        avf = {}
        %Global properties
        xspace = linspace(-10,10,50);
        yspace = linspace(-10,10,50);
        n = 25;
    end
    
    methods
        
        %Add a vector field
        function self = newvf(self,type)
            if strcmp(type,'circ')==1
            self.avf{length(self.avf)+1} = cndr;
            end
            
            if strcmp(type,'line')
                self.avf{length(self.avf)+1} = xycurve;
            end
            
            %Give new field default settings
            self.avf{end}.xspace = self.xspace;
            self.avf{end}.yspace = self.yspace;
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
            Us = {};
            Vs = {};
            for i = 1:length(self.avf)
                if self.avf{i}.active == true
                [X,Y,U,V] = self.avf{i}.ff;
                Us{end+1} = U;
                Vs{end+1} = V;
                end
            end
            
            Ut = zeros(length(self.xspace));
            Vt = zeros(length(self.yspace));
            for i = 1:length(Us)
               for j = 1:length(Us{1})
                    for k = 1:length(Us{1})
                    Ut(j,k) = Ut(j,k)+Us{i}(j,k);
                    Vt(j,k) = Vt(j,k)+Vs{i}(j,k);
                    end
               end
            end

        end
        
        
        function [x,y,u,v] = addLines(self)
     
            for i=1:length(self.xspace)
                for j = 1:length(self.yspace)
                    if self.xspace(i) < 0
                       [u(i,j),v(i,j)]=self.avf{1}.comp(self.xspace(i),self.yspace(j));
                       x(i,j) = self.xspace(i);
                       y(i,j) = self.yspace(j);
                       
                    else
                        [u(i,j),v(i,j)]=self.avf{2}.comp(self.xspace(i),self.yspace(j));
                       x(i,j) = self.xspace(i);
                       y(i,j) = self.yspace(j);
                        
                    end
                end
            end
        end

       
        

%=================== Plotting ====================================%
        function pltff(self)
            [x,y,u,v] = self.sumFields;
            quiver(x,y,u,v);
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

