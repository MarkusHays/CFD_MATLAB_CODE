% Startup of Poiseuille flow between two parallell plates.
% u_t = K + u_xx
% 0 < y < 1
% BC: u_x(t,0) = 0, u(t,1) = 0
% IC: u(0,y) = 0
% FTCS scheme and Matlab's pdepe
clear all
close all
clc

jmax=11;
u=zeros(jmax,1);
new_u=u;
dy=1/(jmax-1);
y=linspace(0,1,jmax);
tmax=.5;            % Steady state after t~3
dt=0.005;
nmax=ceil(tmax/dt);
r=dt/dy^2           % Stability criteria: r <= 0.5
K=2;

for n=1:nmax
    new_u(1)=K*dt + u(1)*(1-2*r) + r*(2*u(2));  % BC from the original PDE
    for j=2:jmax-1
        new_u(j)=K*dt + u(j)*(1-2*r) + r*(u(j+1)+u(j-1));
    end
    u=new_u;
%    u(1)=(4*u(2)-u(3))/3;           % BC from 2nd order forward difference
%    u(1)=u(2);                      % BC from 1st order forward difference
    plot(u,y,'ro')
    axis([0 1 0 1])
    title(['Time = ',num2str(n*dt,2)])
    drawnow;
    %pause
end

hold on

m = 0;
x = linspace(0,1,11);
t = linspace(0,tmax,3);

u = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
plot(u(end,:),x)           % Look at only the last solution, for tmax
legend('FTCS','pedepe')


