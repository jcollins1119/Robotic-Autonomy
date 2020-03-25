% test_pfrs.m programmed by Tomo Furukawa
clear all;
close all;

dt = 0.2;   nk = 10;
% Create control space
u1min = 2000/60/pi;   u1max = 8000/60/pi;   nu1 = 50;
u2min = -pi/3;   u2max = pi/3;   nu2 = 50;
%u1min = -2000/60/pi;   u1max = 2000/60/pi;   nu1 = 50;
%u2min = -2000/60/pi;   u2max = 2000/60/pi;   nu2 = 50;
U = create_space2d(u1min, u1max, nu1, u2min, u2max, nu2);

um = [6000/60/pi; 0];
uS = [3000/60/pi, 0; 0, pi/20];
%um = [0/60/pi; 0/60/pi];
%uS = [2000/60/pi, 0; 0, 2000/60/pi];
U.pi = gauss2d(U.xi, U.yi, um, uS);
surf(U.xi, U.yi, U.pi);
shading interp; view(2);    pause;

plot(0, 0, 'o');  axis equal;   hold on;
l = 0;
for i = 1:U.nx
    for j = 1:U.ny
        x = 0;  y = 0;  th = 0;
        for k = 1:nk
%             [dx, dy, dth] = ackerman(x, y, th, U.x(i), U.y(j));
            [dx, dy, dth] = differential(x, y, th, U.x(i), U.y(j));
            x = x + dt * dx;
            y = y + dt * dy;
            th = th + dt * dth;
        end
        XY.xi(i,j) = x;  XY.yi(i,j) = y;
        l = l + 1;  XY.x(l) = x;    XY.y(l) = y;    XY.p(l) = U.pi(i,j);
    end
end

XY.xmin = min(min(XY.xi));  XY.xmax = max(max(XY.xi));  XY.nx = 50;
XY.ymin = min(min(XY.yi));  XY.ymax = max(max(XY.yi));  XY.ny = 50;
XY.pi = normFsWs(XY, U);

surf(XY.xi, XY.yi, XY.pi);
xlabel('x');    ylabel('y');
shading interp; axis square;