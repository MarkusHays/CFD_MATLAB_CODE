% 1D gas equations, inviscid.

% Continuity:  rho_t +rho*u_x + u *rho_x = 0
% Momentum:    u_t + u*u_x = - (RT/rho)*rho_x

% Boundary conditions, using ghost cells i=1 and i=imax: 
% rho_x(0)=0, u(0)=0, rho(1)=rho0, u_x(1)=0.
% Here, discretisized on a staggered mesh, 1.st order upwind scheme

clear all
close all
clc

imax=20;
dx=1/(imax-1.5);
u=zeros(imax,1);        % Initially at rest
nu=u;
rho=ones(imax,1)*.5;    % Initial density inside a tube
nrho=rho;
RT=287*293;
rho(imax)=1.25;         % Boundary value on the sudden opening
nrho(imax)=1.25;

dt=0.00002;            % Even upwind scheme need very small dt :-(
r=dt/dx;
c=sqrt(1.4*RT);
tmax=1/c;               % Stop when the wave should have reached the end of the tube
nmax=ceil(tmax/dt);
X=linspace(0,1,imax);
plot(X,rho,X,u/c,[0 0],[-1 3],'k')
grid on
pause
for n=2:nmax
    for i=2:imax-1
        uave=(u(i)+u(i-1))/2;
        if uave>0
            nrho(i)=rho(i)-r*rho(i)*(u(i)-u(i-1))-r*uave*(rho(i)-rho(i-1));
        else
            nrho(i)=rho(i)-r*rho(i)*(u(i)-u(i-1))-r*uave*(rho(i+1)-rho(i));
        end
        if u(i)>0
            nu(i)=u(i)-r*u(i)*(u(i)-u(i-1))-2*RT*r*(rho(i+1)-rho(i))/(rho(i+1)+rho(i));
        else
            nu(i)=u(i)-r*u(i)*(u(i+1)-u(i))-2*RT*r*(rho(i+1)-rho(i))/(rho(i+1)+rho(i));
        end
    end
    rho=nrho;
    u=nu;
    rho(1)=rho(2);
    u(imax)=u(imax-1);
    plot(X,rho,X,u/c,[0 0],[-1 3],'k')
    grid on
    title(num2str(n*dt))
    drawnow;
end
