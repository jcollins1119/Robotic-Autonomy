% test_condPDF2d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 50;
ymin = -8;   ymax = 8;   ny = 40;
t_all = [];
nx_all = [];

for k = 1:10
    nx = 10*k;
    ny = nx;
    
tic


XY = create_space2d(xmin,xmax,nx,ymin,ymax,ny);

mxy1 = [0;0];   Sxy1 = [1.5,0;0,1.5];
XY.pxy1i = gauss2d(XY.xi, XY.yi, mxy1, Sxy1);

figure(1)
surf(XY.xi, XY.yi, XY.pxy1i);
axis([XY.xmin, XY.xmax, XY.ymin, XY.ymax]);
xlabel('x_1');    ylabel('x_2');   zlabel('p');
shading interp; colorbar;

mxy2Gxy1 = [2;4];   Sxy2Gxy1 = [0.8,0;0,0.8];


for i = 1:nx
    for j = 1:ny
        XY.pxy2Gxy1i(:,:,i,j) = gauss2d(XY.xi, XY.yi,...
            [XY.x(i);XY.y(j)]+mxy2Gxy1, Sxy2Gxy1);
    end
end

ti = toc;

t_all = [t_all; ti];
nx_all = [nx_all; nx]; 
end
XY.pxy2i = intF1xyzF2xyWxy(XY.x, XY.y, XY.pxy2Gxy1i, XY.pxy1i);

surf(XY.xi, XY.yi, XY.pxy2i);
axis([XY.xmin, XY.xmax, XY.ymin, XY.ymax]);
xlabel('x_1');    ylabel('x_2');   zlabel('p');
shading interp; colorbar;





figure(3)
plot(nx_all,t_all)