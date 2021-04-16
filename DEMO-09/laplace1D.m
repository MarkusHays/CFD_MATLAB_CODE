% Solution of 1D Laplace eqn: u_xx = 0
% discretized with central space scheme.
% Boundary conditions: u(0) = 0 and u(1) = 1.

clear all
close all
clc
imax=100;
u=zeros(imax+2,1);
u(imax+2)=1;
plot(u)
title('Press any key...')
pause

% Solved with Successive Over-Relxation, SOR:
omega=1.94;
for iter=1:150
    res=0;
    for i=2:imax+1
        fi=u(i+1)-2*u(i)+u(i-1);
        res=res+abs(fi);
        u(i)=u(i)+omega*fi/2;
    end
    plot(u)
    title(['Iteration=',int2str(iter),' Res=',num2str(res,2)])
    drawnow;
end

% Solved dirctly using MATLAB's mldivide, \:
A=diag(ones(imax,1)*(-2));
A=A+diag(ones(imax-1,1),1)+diag(ones(imax-1,1),-1);
b=zeros(imax,1);
b(imax)=-1;
v=A\b;
hold on
v=[0;v;1];
plot(v,'r+')
hold off
legend('Iterative solution','MATLABs A\\b','Location','best')