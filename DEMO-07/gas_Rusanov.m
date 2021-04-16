% 1D gas equations, inviscid.

% Continuity:  rho_t +(rho*u)_x = 0
% Momentum:    (rho*u)_t + (rho*u^2+c^2rho)_x = 0

% Boundary conditions, using ghost cells i=1 and i=imax: 
% rho_x(0)=0, u(0)=0, rho(1)=rho0, u_x(1)=0.
% Here, discretisized on a colocated mesh, Rusanov method.

clear all
close all
clc
imax=40;
rho0=1.25;
RT=287*293;
c=sqrt(1.4*RT);
rho=ones(imax,1)*0.;    % Initial density inside a tube
rho(imax)=rho0;          % Boundary value on the sudden opening
nrho=rho;
u=zeros(imax,1);         % Initially at rest
nu=u;
dt=.00001;
h=1/(imax-2);
X=linspace(-h/2,1+h/2,imax);
r=dt/h;
tmax=10/c;                % Time = 1/c is when the wave should have reached the end of the tube
plot(X,rho,X,u/c,[0 0],[-1.5 3.5],'k')
legend('\rho','u/c')
grid on
pause

for n=2:ceil(tmax/dt)
    for i=2:imax-1
        ajp=max(abs(u(i))+c,abs(u(i+1))+c);
        ajm=max(abs(u(i-1))+c,abs(u(i))+c);
        Fp=0.5*(rho(i)*u(i)+rho(i+1)*u(i+1)-abs(ajp)*(rho(i+1)-rho(i)));
        Fm=0.5*(rho(i-1)*u(i-1)+rho(i)*u(i)-abs(ajm)*(rho(i)-rho(i-1)));
        nrho(i)=rho(i)-r*(Fp-Fm);

        Fp=0.5*(rho(i)*u(i)^2+rho(i)*c^2+rho(i+1)*u(i+1)^2+rho(i+1)*c^2-abs(ajp)*(rho(i+1)*u(i+1)-rho(i)*u(i)));
        Fm=0.5*(rho(i-1)*u(i-1)^2+rho(i-1)*c^2+rho(i)*u(i)^2+rho(i)*c^2-abs(ajm)*(rho(i)*u(i)-rho(i-1)*u(i-1)));
        nu(i)=u(i)-r*(Fp-Fm);
    end
    nrho(1)=nrho(2);
    nu(imax)=nu(imax-1);
    u=nu;
    rho=nrho;
    plot(X,rho,X,u/c,[0 0],[-1.5 3.5],'k')
    title(num2str(n*dt))
    grid on
    drawnow;
    max(abs(u))*dt/h
    if sum(isnan(u))>0.5;break;end
end
    