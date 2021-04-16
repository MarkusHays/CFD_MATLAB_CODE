function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
% Sets the boundary conditions to (r)ight and (l)eft:
pl = 0;
ql = 1;
pr = ur;
qr = 0;