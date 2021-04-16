% One-dimensional wave equation:
% u_tt = a0*u_xx
% solved with Central-Time Central-Space scheme.
clear all
close all
clc
xmax=10;
h=0.1;
x=linspace(-xmax,xmax,round(2*xmax/h+1));
imax=length(x);
u=x*0;
nu=u;
ou=u;
a0=1;
dt=0.1;
C=dt*a0/h      % Stability limit: C <= 1
tmax=100;
A=0.25;
plot(x,u)
axis([-xmax xmax -1 1])

for n=1:ceil(tmax/dt)
    if n*dt<2*pi
        u(1)=A*(1-cos(n*dt));    % Create a wave from left boundary
    else
        u(1)=0;                  % Dirichlet BC
    end
    for i=2:imax-1
        nu(i)=u(i)*(2-2*C^2)+C^2*(u(i+1)+u(i-1))-ou(i);
    end
    % Right BC: 1st order Neumann
    %nu(imax)=nu(imax-1);

    % Right BC: 2nd order Neumann
    nu(imax)=u(imax)*(2-2*C^2)+C^2*(2*u(imax-1))-ou(imax);
    ou=u;
    u=nu;
    plot(x,u)
    title(['Time = ',num2str(n*dt,3)])
    axis([-xmax xmax -1 1])
    drawnow;
end