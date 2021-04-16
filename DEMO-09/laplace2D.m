% Solving the Laplace eqn for the stream-function around Donald and his
% car using Gauss-Seidel iteration, or Succesive Over-Relaxation (SOR)
% Uses the images as mesh system:
% "image1small.jpg"   250 x 150
% "image1.jpg"       1000 x 600

clear all
close all
clc
info=imfinfo('image1small.jpg');
imax=info.Width;
jmax=info.Height;
rgb=imread('image1small.jpg');
imshow(rgb)

a=false(imax,jmax);  % Logical: a(i,j)=1 is a live cell, a(i,j)=0 is inside the figure
for i=1:imax
    for j=1:jmax
        a(i,j)=sum(rgb(j,i,:))<230*3;  % White is 255*3, so this is bright gray
    end
end

p=zeros(imax,jmax);
p(:,1)=1;  % Top value for the stream function
for i=1:imax
    for j=1:jmax
        if ~a(i,j)
            p(i,j)=1-(j-1)/(jmax-1); % Left boundary value, also initial values
        end
    end
end
hold on
contour(p'*255,[.05:0.05:1]*255)
hold off
title('Press any key...')
pause

omega=1.97;      % SOR: an efficient omega will be close to 2. omega=1 is Gauss-Seidel
for iter=1:200
    res=0;       % Calculates the residuals to have a monitor for the quality of the solution
    for i=2:imax-1
        for j=2:jmax-1
            if ~a(i,j)
                fij=p(i+1,j)+p(i-1,j)+p(i,j+1)+p(i,j-1)-4*p(i,j);
                res=res+abs(fij);
                p(i,j)=p(i,j)+omega*fij/4;
            end
        end
    end
    for j=1:jmax
        p(imax,j)=p(imax-1,j);  % Right boundary condition
    end
    if mod(iter,10)==0
        imshow(rgb)
        hold on
        contour(p'*255,[.05:0.05:1]*255)   % This can be commented out for speed
        hold off
    end
    title(['Iteration=',int2str(iter),' res=',num2str(res,2)])
    drawnow;
end
imshow(rgb)
hold on
contour(p'*255,[.05:0.05:1]*255)
hold off
title(['Iteration=',int2str(iter),' res=',num2str(res,2)])
