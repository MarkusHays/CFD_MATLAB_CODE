% Startup of Poiseuille flow in a square duct.
% u_t = K + u_xx + u_yy
% -1 < x < 1, -1 < y < 1
% BC: u = 0 on the boundary: x,y = +/- 1
% IC: u(0,x,y) = 0
% FTCS scheme
clear all
close all
clc
jmax=21;
imax=jmax;
u=zeros(imax,jmax);
new_u=u;
dy=2/(jmax-1);
y=linspace(-1,1,jmax);
[x,y]=meshgrid(-1:dy:1,-1:dy:1);
tmax=1;
dt=0.0025;     % Different stability limit:
r=dt/dy^2      % r <= 0.25
nmax=ceil(tmax/dt);
K=2;

for n=1:nmax
    for j=2:jmax-1
        for i=2:imax-1
            new_u(i,j)=K*dt + u(i,j)*(1-4*r)...
                       + r*(u(i,j+1)+u(i,j-1)+u(i+1,j)+u(i-1,j));
        end
    end
    u=new_u;
    surf(x,y,u)
    axis([-1 1 -1 1 0 .6])
    title(['Time = ',num2str(n*dt,2)])
    drawnow;
    % pause
end
