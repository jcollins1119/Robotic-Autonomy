% test_vpfov.m programmed by Tomo Furukawa
clear all;
close all;

S_x_min = -4;  S_x_max = 4;  nx = 10;
S_y_min = -3; S_y_max = 3;    ny = 8;
FoV = create_space2d(S_x_min, S_x_max, nx, S_y_min, S_y_max, ny);

xc_min = -3.5;   xc_max = 3.5;
yc_min = -2.5;   yc_max = 2.5;
w = 7;
for i = 1:ny
    fx(:,i) = 1./(exp(-w*(FoV.x-xc_min))+1)-1./(exp(-w*(FoV.x-xc_max))+1);
end
for i = 1:nx
    fy(i,:) = 1./(exp(-w*(FoV.y-yc_min))+1)-1./(exp(-w*(FoV.y-yc_max))+1);
end
FoV.pi = (fx + fy)/2;
surf(FoV.xi, FoV.yi, FoV.pi);   shading interp; 
xlabel('^{S}x');    ylabel('^{S}y');     zlabel('PoD');
%view(2);
pause;

S.x = 2;    S.y = 1;    S.th = -5*pi/12;
for i = 1:nx
    for j = 1:ny
        y = transform_p2d([FoV.xi(i,j), FoV.yi(i,j)], [S.x, S.y, S.th]);
        xi(i,j) = y(1); yi(i,j) = y(2);
    end
end
surf(xi, yi, FoV.pi);   shading interp; axis equal;
xlabel('x');    ylabel('y');     zlabel('PoD');
%view(2);
