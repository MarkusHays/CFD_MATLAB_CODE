% Mandelbrot: a demo of the imortance of precision.
% Always start a script with theese three:
clear all
close all
clc

% Plot the initial figure:
d=3;
dx=d/600;
[x,y]=ndgrid(-d/2:dx:d/2); c=x+1i*y; z=c; for k=1:50, z=z.^2+c; end, contourf(x,y,abs(z))

% Use the mouse position to zoom in a factor 100:
while 1
    [x0,y0] = ginput(1);
    d=d/100;
    dx=d/600;
    [x,y]=ndgrid(x0-d/2:dx:x0+d/2,y0-d/2:dx:y0+d/2); c=x+1i*y; z=c; for k=1:50, z=z.^2+c; end, contourf(x,y,abs(z)<1e6)
end