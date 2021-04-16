% Solving the 2D wave eqn:
% u_tt = a0^2*[u_xx + u_yy]
% solved with centered time centered space scheme
% in an elliptic domain.
clear all
close all
clc
a=10;
b=6;
h=0.1;
[x,y]=meshgrid(-a:h:a,-b:h:b);
[imax,jmax]=size(x);
u=x*0;
nu=u;
ou=u;
a0=1;
dt=0.0707;     % Stability limit: C <= 1/sqrt(2)
C=dt*a0/h
tmax=44;
% Creating elliptic boundary:
e=(x/a).^2+(y/b).^2<1;
f=sqrt(a^2-b^2)            % x-position of focal point

% Initial disturbance in left focal point:
A=.25;
for i=54:68
    for j=14:28
        u(i,j)=A*(1-cos((68-i)*2*pi/15))*(1-cos((28-j)*2*pi/15));
    end
end
u(imax,jmax)=A*3;   % Using corner values as a scale for surf
u(imax,1)=-A*3;
nu(imax,jmax)=A*3;
nu(imax,1)=-A*3;
ou=u;
surf(x,y,u+0.2*(1-e))
colormap jet
pause
for n=1:ceil(tmax/dt)
    for i=2:imax-1
        for j=2:jmax-1
            if e(i,j)
                temp=u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1);
                nu(i,j)=u(i,j)*(2-4*C^2)+C^2*temp-ou(i,j);
            end
        end
    end
    ou=u;
    u=nu;
    surf(x,y,u+0.2*(1-e))
%    shading interp
    title(['Time=',num2str(n*dt,3)])
    drawnow;
end