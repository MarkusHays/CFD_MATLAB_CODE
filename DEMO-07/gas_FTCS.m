% 1D gas equations, inviscid.

% Continuity:  rho_t +rho*u_x + u *rho_x = 0
% Momentum:    u_t + u*u_x = - (RT/rho)*rho_x

% Boundary conditions, using ghost cells i=1 and i=imax: 
% rho_x(0)=0, u(0)=0, rho(1)=rho0, u_x(1)=0.
% Here, discretisized on a staggered mesh, FTCS scheme

clear all
close all
clc
imax=20;
X=linspace(0,1,imax);
RT=287*293;
c=sqrt(1.4*RT);
rho=ones(imax,1)*0.5;    % Initial density inside a tube
rho(imax)=1.25;          % Boundary value on the sudden opening
nrho=rho;
u=zeros(imax,1);         % Initially at rest
nu=u;
dt=.000001;              % FTCS seems to be unconditionally unstable :-(
dx=1/(imax-1.5);
r=dt/dx;
tmax=1/c;                % Stop when the wave should have reached the end of the tube

plot(X,rho,X,u/c,[0 0],[-1 3],'k')
legend('\rho','u/c')
grid on
pause

for n=2:ceil(tmax/dt)
    for i=2:imax-1
        nrho(i)=rho(i)-r*rho(i)*(u(i)-u(i-1))...
            -r*(u(i)+u(i-1))*(rho(i+1)-rho(i-1))/4;
        nu(i)=u(i)-r*u(i)*(u(i+1)-u(i-1))/2 ...
        -2*RT*r*(rho(i+1)-rho(i))/(rho(i+1)+rho(i));
    end
    nrho(1)=nrho(2);
    nu(imax)=nu(imax-1);
    u=nu;
    rho=nrho;
    plot(X,rho,X,u/c,[0 0],[-1 3],'k')
    grid on
    drawnow;
end
