function [c,f,s] = pdex1pde(x,t,u,DuDx)
% Defines the pde to be solved:
c = 1;
f = DuDx;
s = 2;
