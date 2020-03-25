% test_gauss2d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
ymin = -8;   ymax = 8;   ny = 100;
XY = create_space2d(xmin, xmax, nx, ymin, ymax, ny);

m = [0; 0];   
S = [5, 0; 0, 2];

XY.pi = gauss2d(XY.xi, XY.yi, m, S);

surf(XY.xi, XY.yi, XY.pi);
xlabel('x');    ylabel('y');    zlabel('p');
%axis([XY.xmin, XY.xmax, XY.ymin, XY.ymax])
axis equal;
view(2);
shading interp;
