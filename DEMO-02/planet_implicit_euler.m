% Demo: planetal orbit around the sun using 1.order backward (=implicit) 
% Euler scheme. The non-linear equation system is solved with fsolve.
clear all
clc
close all
global dt x0 y0 u0 v0
tmax=10;
dt=0.01;
x=1;
y=0;
u=0;
v=1;
figure(1)
plot(0,0,'ro','MarkerSize',40,'MarkerFaceColor','r')
axis([-2 2 -1.5 1.5])
hold on
h=plot(x,y,'bo','MarkerSize',20);   % handle to the graphic object for animation
options = optimset('Display','off');

for i=1:ceil(tmax/dt)
    x0=x;y0=y;u0=u;v0=v;
    [S,fval,exitflag] = fsolve(@funk,[x,y,u,v],options);
    x=S(1);
    y=S(2);
    u=S(3);
    v=S(4);
    set(h,'XData',x,'YData',y)   % Change the position
    if mod(i,10)==0             % Make a small path marker
        plot(x,y,'b.')
    end
    drawnow;
end
hold off

