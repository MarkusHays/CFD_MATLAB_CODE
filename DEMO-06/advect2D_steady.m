% Solving the steady 2D advection eqn:
% u*F_x + v*F_y = 0,  u=v=1
% solved with cetral and upwind schemes.
% BC: F(x=0,y)=1, F(x,y=1)=0
clear all
close all
clc
n=10;
F=zeros(n);
F(1,2:n)=1; % Left boundary values
F2=F;
for i=2:n
    for j=2:n
        F(i,j)=(F(i-1,j)+F(i,j-1))/2;
    end
end
v=[0:.1:1];
contourf(F',v)

figure(2)
for i=2:n-1
    for j=2:n-1
        F2(i,j+1)=-F2(i+1,j)+F2(i,j-1)+F2(i-1,j);
    end
end
v=[0:.1:1];
contourf(F2',v)