function res=funk(Y)
global dt x0 y0 u0 v0
x=Y(1);
y=Y(2);
u=Y(3);
v=Y(4);
res=[x-x0-dt*u;
     y-y0-dt*v;
     u-u0+dt*x/(x^2+y^2)^(3/2);
     v-v0+dt*y/(x^2+y^2)^(3/2)];
