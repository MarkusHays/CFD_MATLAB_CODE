% Stiff ODE example: Flame propagation model
%http://se.mathworks.com/company/newsletters/articles/stiff-differential-equations.html
clear all
close all
clc
delta=0.0001;          % The smaller the delta, the stiffer the ODE becomes
tmax=2/delta;
F=@(t,y)y^2-y^3;       % Anonymous function
opt=odeset('RelTol',1e-4);
[t,y]=ode45(F,[0 tmax],delta,opt);     % ode45 has trouble, ode23s is ok

a=1/delta-1;
ya=1./(lambertw(a*exp(a-t))+1);     % Analytical solution
plot(t,y,'-+',t,ya)

syms y
y=dsolve('Dy=y^2-y^3','y(0)=delta') % Check analytical solution
y=simplify(y,1000);
pretty(y)
