% Startup of Poiseuille flow between two parallell plates.
% u_t = K + u_xx
% -1 < y < 1
% BC: u(t,-1) = 0, u(t,1) = 0
% IC: u(0,y) = 0
% FTCS scheme
clear all
close all
clc
global jmax K dy
jmax=21;
u=zeros(jmax,1);
new_u=u;
dy=2/(jmax-1);
y=linspace(-1,1,jmax);
tmax=3;
dt=0.005;
nmax=ceil(tmax/dt);
r=dt/dy^2              % Stability criteria: r <= 0.5
K=2;
u_steady=.5*K*(1-y.^2);

for n=1:nmax
    for j=2:jmax-1
        new_u(j)=K*dt + u(j)*(1-2*r) + r*(u(j+1)+u(j-1));
    end
    u=new_u;
    plot(u,y,u_steady,y,'ro')
    axis([0 1 -1 1])
    title(['Time = ',num2str(n*dt,2)])
    %drawnow;
   % pause
end

% Matlab's ODE-solvers: Try different solvers and see how many timesteps
% they need. Also, try [0:0.5:tmax] as timespan.
u=u*0;
[t,u]=ode45(@funk,[0 tmax],u(2:jmax-1));
y=linspace(-1+dy,1-dy,jmax-2);
hold on
plot(u,y)
hold off
%% 
% <include>funk.m</include>