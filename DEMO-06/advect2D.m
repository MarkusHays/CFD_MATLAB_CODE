% Solving the 2D advect eqn:
% F_t + a0*[F_x + F_y] = 0
% solved with FTCS and FTUS schemes
clear all
close all
clc
a=10;
h=0.2;
[x,y]=meshgrid(-a:h:a,-a:h:a);
[imax,jmax]=size(x);
F=x*0;
nF=F;
a0=1;
dt=0.1;     
C=dt*a0/h
tmax=10;
% Initial disturbance:
A=.25;
for i=48:52
    for j=48:52
        F(i,j)=A;
    end
end
F(imax,jmax)=A;   % Using corner values as a scale for surf
F(imax,1)=-A;
nF(imax,jmax)=A;
nF(imax,1)=-A;
surf(x,y,F)
colormap jet
pause
for n=1:ceil(tmax/dt)
    for i=2:imax-1
        for j=2:jmax-1
            % FT-Central scheme:
%            temp=F(i+1,j)-F(i-1,j)+F(i,j+1)-F(i,j-1);
%            nF(i,j)=F(i,j) -temp*C/2;

            % FT-Upwind scheme:
            temp=F(i-1,j)+F(i,j-1);
            nF(i,j)=F(i,j)*(1-2*C)+C*temp;

            % Analytical solutior for C=1:
%            nF(i,j)=F(i-1,j-1);
        end
    end
    F=nF;
    surf(x,y,F)
    %    shading interp
    title(['Time=',num2str(n*dt,3)])
    drawnow;
end