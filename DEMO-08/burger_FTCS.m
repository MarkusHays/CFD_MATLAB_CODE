% TEP4280: Simulation of traffic by Burgers eqn., FTCS scheme.
% d(rho)/dt + d(rho*(1-rho))/dx = 0
clear all
close all
clc

xmin=-30;
xmax=30;
r=@(x)0.2+0.8*exp(-(x/10).^2);
N=100;
X=linspace(xmin,xmax,N);
rho=r(X);


figure('Name','Burgers, FTCS scheme')
plot(X,rho,':r')
axis([xmin xmax 0 1.1])
hold on
h=plot(X,rho);
legend('\rho(t=0)','\rho(t)','Location','Best')
dt=0.01;     % Unconditionally unstable; just try with smaller dt :-)
tmax=25;
dx=(xmax-xmin)/(N-1);
ht=title('t = 0');
pause
for n=1:ceil(tmax/dt)
    for k=2:N-1
        right=rho(k+1)*(1-rho(k+1));
        left=rho(k-1)*(1-rho(k-1));
        nrho(k)=rho(k)-dt*(right-left)/(2*dx);
    end
    rho=nrho;
    rho(1)=0.2;
    rho(N)=rho(N-1);
    set(h,'YData',rho)
    set(ht,'String',['t = ',num2str(n*dt,'%6.2f')])
    drawnow;
end
hold off