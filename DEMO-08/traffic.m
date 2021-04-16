% Simulation of traffic by individual cars.

clear all
close all
clc

xmin=-30;
xmax=30;
r=@(x)0.2+0.8*exp(-(x/10).^2);    % Initial density distribution
X=linspace(xmin,xmax);

figure('Name','Individual car simulation')
subplot(4,1,4)
plot(X,r(X))
axis([xmin xmax 0 1])
title('Density at time t = 0')
hold on

Xk(1)=-100;
k=1;
while Xk(end)<100
    Xk(k+1)=Xk(k)+1/r(Xk(k));   % Initial density: rho = car_length/(X(k+1) - X(k))
    k=k+1;
end
nXk=Xk;
Xk_init=Xk;
plot(Xk,r(Xk),'rs')
hold off

subplot(4,1,[2 3])
plot(Xk,0,'rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',10)    % Initial positions of individual cars
dt=0.1;
tmax=25;
axis([xmin xmax 0 tmax])
title('Trajectories of individual cars')
hold on
for t=0:dt:tmax
    for k=1:length(Xk)-1
        rhok=1/(Xk(k+1)-Xk(k));
        U=1-rhok;
        nXk(k)=Xk(k)+dt*U;      % New position for car k
    end
    Xk=nXk;
    plot(Xk,t,'b.')
end
hold off

subplot(4,1,1)
N=length(Xk);
plot(Xk(1:N-1),1./(Xk(2:N)-Xk(1:N-1)),'rs')  % End car density
axis([xmin xmax 0 1])
title('Density at time t = 25')

figure('Name','Animation of car movement')
Xk=Xk_init;
h=plot(Xk,Xk*0,'rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',10);      % Here, h is the handle to the graphics to be animated
axis([xmin xmax -1 1])
dt=0.05;
pause
for t=0:dt:tmax
    for k=1:N-1
        rhok=1/(Xk(k+1)-Xk(k));
        U=1-rhok;
        nXk(k)=Xk(k)+dt*U;
    end
    Xk=nXk;
    set(h,'XData',Xk);        % Change the x-positions for the cars
    title(['Time = ',num2str(t,2)])
    drawnow;
end


