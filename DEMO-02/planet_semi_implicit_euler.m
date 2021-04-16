% Demo: planetal orbit around the sun using 1.order semi-implicit Euler
% scheme.
% The line S=A\b solves the equation system for the unknowns, but with the
% r from previous timestep, hence "semi-".
close all
clear all
clc
% MG = 1 so we skip him
tmax=10;
dt=0.01;
n=ceil(tmax/dt);
x=1;
y=0;
u=0;
v=1;
figure(1)
plot(0,0,'ro','MarkerSize',40,'MarkerFaceColor','r')
axis([-2 2 -1.5 1.5])
hold on
h=plot(x,y,'bo','MarkerSize',20);   % handle to the graphic object for animation

for i=1:n-1
    r=sqrt(x^2+y^2);
    A=[1 0 -dt 0;
        0 1 0 -dt;
        dt/r^3 0 1 0;
        0 dt/r^3 0 1];
    b=[x; y; u; v];
    S=A\b;
%    S=inv(A)*b;   % inv is slow compared to \
    x=S(1);
    y=S(2);
    u=S(3);
    v=S(4);
    set(h,'XData',x,'YData',y)   % Change the position
    if mod(i,10)==0              % Make a small path marker
        plot(x,y,'b.')
    end
    drawnow;
end
hold off

    
