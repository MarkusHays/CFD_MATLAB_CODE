% Solving the 1D diffusion equation: Start-up of Couette flow 
% using Forward-Time-Central-Space (FTCS) scheme,
% and comparing with analytical solutions.
% u_t = u_yy
% The equation is non-dimensional, so 0<y1 and 0<t<1.
% Boundary Conditions: u(t,0) = 0, u(t,1) = 1
% Initial Condition: u(0,y) = 0
clear all
close all
clc
jmax=21;
u=zeros(jmax,1);
u(jmax)=1;             % Right boundary condition
new_u=u;
dy=1/(jmax-1);
y=linspace(0,1,jmax);
tmax=1;
dt=0.00125;
nmax=ceil(tmax/dt);
r=dt/dy^2              % Stability criteria: r <= 0.5
for n=1:nmax
    for j=2:jmax-1
        new_u(j)=u(j)*(1-2*r) + r*(u(j+1)+u(j-1));
    end
    u=new_u;
    
    % Analytical solution:
    t=dt*n;
    U=zeros(1,jmax);
    for i=1:15
        U=U+sin(i*pi*(1-y))*exp(-(i*pi)^2*t)/i;
    end
    U=y-2*U/pi;
    
    % Another analytical solution:
    t=0.5/sqrt(t);
    U2=zeros(1,jmax);
    for i=0:5
        U2=U2+erfc((2*i+1-y)*t)-erfc((2*i+1+y)*t);
    end
    plot(u,y,U,y,'ro',U2,y,'g+')
    
    title(['Time = ',num2str(n*dt,2)])
    drawnow;
    %pause                       % Use this if you want stepwise simulation
end
