% Demo: planetal orbit around the sun using 1.order forward Euler scheme.
clear all
clc
close all
MG=1;
tmax=100;
dt=0.01;   % This is way too big, even 0.001 makes the planet drift outwards

x=1;
y=0;
u=0;
v=1;
figure(1)
plot(0,0,'ro','MarkerSize',40,'MarkerFaceColor','r')
axis([-1.5 1.5 -1.5 1.5])
hold on
h=plot(x,y,'bo','MarkerSize',20);   % handle to the graphic object for animation

for i=1:ceil(tmax/dt)
    r=sqrt(x^2+y^2);
    xnew=x+dt*u;
    ynew=y+dt*v;
    u=u-dt*MG*x/r^3;
    v=v-dt*MG*y/r^3;
    x=xnew;y=ynew;
    set(h,'XData',x,'YData',y)   % Change the position
    if mod(i,100)==0             % Make a small path marker
        plot(x,y,'b.')
    end
    drawnow;
end
hold off
    
