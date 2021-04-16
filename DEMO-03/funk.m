function ddu=funk(t,y)
global jmax K dy
u=zeros(jmax,1);
u(2:jmax-1)=y;
ddu=K+(u(3:jmax)-2*u(2:jmax-1)+u(1:jmax-2))/dy^2;
