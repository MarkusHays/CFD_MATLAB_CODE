% TEP4280: Simulation of traffic by Burgers eqn., upwind scheme.
% d(rho)/dt + f'*d(rho)/dx = 0
clear all
close all
clc

xmin=-30;
xmax=30;
r=@(x)0.2+0.8*exp(-(x/10).^2);
N=100;
X=linspace(xmin,xmax,N);
rho=r(X);
nrho=rho;

figure('Name','Burgers, Upwind scheme')
plot(X,rho,':r')
axis([xmin xmax 0 1])
hold on
h=plot(X,rho);
legend('\rho(t=0)','\rho(t)','Location','Best')

pause
dt=.1;    % Stable up to dt=1
tmax=25;
dx=(xmax-xmin)/(N-1);
ht=title('t = 0');
iso=zeros(ceil(tmax/dt),N);   % Store results here for plotting afterwards
for n=1:ceil(tmax/dt)
    for k=2:N-1
        dfdrho=1-2*rho(k);    % f' = "velocity" in front of d(rho)/dx
        if dfdrho>0
           nrho(k)=rho(k)-dt*dfdrho*(rho(k)-rho(k-1))/dx;
        else
           nrho(k)=rho(k)-dt*dfdrho*(rho(k+1)-rho(k))/dx;
        end
    end
    rho=nrho;
    rho(1)=0.2;
    rho(N)=rho(N-1);
    set(h,'YData',rho)
    set(ht,'String',['t = ',num2str(n*dt,'%6.2f')])
    drawnow;
    iso(n,:)=rho;
end
hold off

figure('Name','Burgers eqn., Upwind scheme')
subplot(4,1,1)
plot(X,rho)
title('Density at time t = 25')
subplot(4,1,4)
plot(X,r(X))
title('Density at time t = 0')
subplot(4,1,[2 3])
T=linspace(0,tmax,ceil(tmax/dt));
contour(X,T,iso,r(X))
title('Contourplot of \rho')