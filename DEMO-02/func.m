% Function to be used by ode45. It must return the four derivatives for the
% four 1.order equations.
function ddt=func(t,Y)
global MG
x=Y(1);
y=Y(2);
u=Y(3);
v=Y(4);
r=sqrt(x^2+y^2);
ddt=[u;
     v;
    -MG*x/r^3;
    -MG*y/r^3];