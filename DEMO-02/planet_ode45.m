% Demo: planetal orbit around the sun using ode45.
clear all
clc
close all
global MG
MG=1;
tmax=6.28*100;   % 100 rounds

x=1;
y=0;
u=0;
v=1;             % This should result in a perfect circle orbit
E0=0.5*(u^2+v^2)-MG/(sqrt(x^2+y^2));
figure('Name','Planet orbit')
plot(0,0,'ro','MarkerSize',40)
axis([-1.5 1.5 -1.5 1.5])
hold on
h=plot(x,y,'bo','MarkerSize',20);

options=odeset('RelTol',1e-6,'AbsTol',1e-10);    % Can specify better accuracy
[t,y]=ode45(@func,[0 tmax],[x y u v],options);
plot(y(:,1),y(:,2))                              % plot(x,y)
hold off

% Check that the total mechanical energy is constant:
figure('Name','Mechanical Energy as a function of time')
E=0.5*(y(:,3).^2 + y(:,4).^2)-MG./(sqrt(y(:,1).^2+y(:,2).^2));
plot(t,E-E0)
xlabel('Time')
ylabel('E_{kinetic} + E_{potential}')

figure(3)
comet(y(:,1),y(:,2))       % MATLAB's built-inn animation


