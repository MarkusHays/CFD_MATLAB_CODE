% Startup of Poiseuille pipe flow.
% u_t = K + u_rr + u_r * 1/r     K=4 gives u(t=inf,r=0)=1
% 0 < r < 1
% BC: u_r(t,0) = 0, u(t,1) = 0
% IC: u(0,y) = 0
% FTCS scheme
clear all
close all
clc

K=4;
N=11;
dr=1/(N-1);
D=.41;
dt=D*dr^2;
u=zeros(N,1);
nu=u;
tmax=2;
r=linspace(0,1,N);
la=besselzero(0,10,1);
R=[0:.1:.9];
u_steady=.25*K*(1-r.^2);

for n=1:ceil(tmax/dt)
    nu(1)=u(1)+K*dt+4*D*(u(2)-u(1));  % BC from the original eqn.
    for j=2:N-1
        nu(j)=u(j)+K*dt+D*(u(j+1)-2*u(j)+u(j-1))+D*(u(j+1)-u(j-1))/(2*(j-1));
    end
    u=nu;
%    u(1)=(4*u(2)-u(3))/3;             % BC from forward difference
%    u(1)=u(2);                        % BC from 1.order forward difference

    % Analytical solution, after Szymanski (1932)
    s=0;
    for j=1:10
        s=s+besselj(0,la(j)*R)*exp(-la(j)^2*n*dt)/(besselj(1,la(j))*la(j)^3);
    end
    U=1-R.^2-8*s;
    plot(u_steady,r,'bo',u,r,U,R,'ro','MarkerSize',10)
    title(['Time = ',num2str(n*dt,2)])
    drawnow;
   %pause
end

