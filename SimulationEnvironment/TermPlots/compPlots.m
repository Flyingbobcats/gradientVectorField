%=========================================================================
% Plots for circular and line vector fields. Individual components and
% summs
%==========================================================================

clc
clear
close all

%Circular Field
circular = false;
normsOffCirc = false;       %Will deactive ALL normilization


%Straight path
straight = true;


if circular
    %Setup Field
    vf = vectorField;
    vf = vf.navf('circ');
    vf =  vf.xydomain(10,0,0,25);
    vf.avf{1}.r = 5;
    
    if normsOffCirc
    vf.avf{1}.normComponents = false;
    vf.avf{1}.normTotal = false;
    vf.normAttractiveFields = false;
    vf.NormSummedFields     = false;
    vf.normAttractiveFields = false;
    vf.normRepulsiveFields  = false;
    end
    
    %Attractive
    figure
    vf.avf{1}.G = 1;
    vf.avf{1}.H = 0;
    vf.avf{1}.L = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Attractive');
    
    %Repulsive
    figure
    vf.avf{1}.G = -1;
    vf.avf{1}.H = 0;
    vf.avf{1}.L = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Repulsive');
    
    %Clockwise Circulation
    figure
    vf.avf{1}.G = 0;
    vf.avf{1}.H = 1;
    vf.avf{1}.L = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('CW Circulation');
    
    %Counter Clockwise Circulation
    figure
    vf.avf{1}.G = 0;
    vf.avf{1}.H = -1;
    vf.avf{1}.L = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('CW Circulation');
    
    %Time Varying
    figure
    vf.avf{1}.G = 0;
    vf.avf{1}.H = 0;
    vf.avf{1}.L = 1;
    vf.avf{1}.vx = 1;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Time Varying');
    
    
    %Summed Convergence and Circulation
    figure
    vf.avf{1}.G = 1;
    vf.avf{1}.H = 1;
    vf.avf{1}.L = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Convergence and Circulation');
    
    %Summed Convergence  Circulation and Time Varying
    figure
    vf.avf{1}.G = 1;
    vf.avf{1}.H = 1;
    vf.avf{1}.L = 1;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Convergence, Circulation, and Time Varying');
    
end





if straight
    vf = vectorField;
    vf = vf.navf('line');
    vf.avf{1}.angle = pi/2;
    vf.avf{1}.LineDistance = 20;
    vf =  vf.xydomain(10,0,0,25);

    
    %Attractive
    figure
    vf.avf{1}.G = 1;
    vf.avf{1}.H = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Attractive');
    
    %Repulsive
    figure
    vf.avf{1}.G = -1;
    vf.avf{1}.H = 0;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Repulsive');
    
    %Circulation
    figure
    vf.avf{1}.G = 0;
    vf.avf{1}.H = 1;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Circulation');
    
    %Negative Circulation
    figure
    vf.avf{1}.G = 0;
    vf.avf{1}.H = -1;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Negative Circulation');
    
    
    %Negative Circulation
    figure
    vf.avf{1}.G = 1;
    vf.avf{1}.H = 1;
    
    hold on
    vf.pltff
    vf.avf{1}.pltfnc
    title('Convergence and Circulation');
    
end
















