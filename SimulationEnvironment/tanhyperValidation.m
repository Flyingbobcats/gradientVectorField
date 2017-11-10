%Tan Hyperbolic decay function validation

clc
clear
close all

vf = vectorField;
vf = vf.nrvf('circ');
vf.rvf{1} = vf.rvf{1}.modDecay('hyper');
vf.rvf{1}.r = 0.01;
vf. NormSummedFields = false;

F = figure;
hold on
vf.pltff
vf.rvf{1}.pltDecay
