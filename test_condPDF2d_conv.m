% test_condPDF2d_conv.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 50;
ymin = -10;   ymax = 10;   ny = 50;
XY = create_space2d(xmin,xmax,nx,ymin,ymax,ny);
mxy1 = [0;0];   Sxy1 = [1.5,0;0,1.5];
XY.pxy1i = gauss2d(XY.xi, XY.yi, mxy1, Sxy1);
XY.intpxy1i = intFxyWxy(XY.x,XY.y,XY.pxy1i);

surf(XY.xi, XY.yi, XY.pxy1i);
xlabel('x_1');    ylabel('x_2');   zlabel('p');
shading interp; axis equal;
view(2);    colorbar;   
pause;

nx2 = 25;   xmin2 = -5;  xmax2 = xmin2 + nx2*XY.dx;
ny2 = 25;   ymin2 = -5;  ymax2 = ymin2 + ny2*XY.dy;
XY2 = create_space2d(xmin2,xmax2,nx2,ymin2,ymax2,ny2);
mxy2Gxy1 = [2;1];   Sxy2Gxy1 = [0.8,0;0,0.8];
XY2.pxy2Gxy1i = gauss2d(XY2.xi, XY2.yi, mxy2Gxy1, Sxy2Gxy1);
XY2.intpxy2Gxy1i = intFxyWxy(XY2.x,XY2.y,XY2.pxy2Gxy1i);

XY.pxy2i = predict2d(XY.dx, XY.dy, XY2.pxy2Gxy1i, XY.pxy1i);
XY.intpxy2i = intFxyWxy(XY.x,XY.y,XY.pxy2i);

surf(XY.xi, XY.yi, XY.pxy2i);
xlabel('x_1');    ylabel('x_2');   zlabel('p');
shading interp;  axis equal; 
view(2);    colorbar;
