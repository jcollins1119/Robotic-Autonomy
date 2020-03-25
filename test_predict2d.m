% test_predict2d.m programmed by Tomo Furukawa
clear all;
close all;
global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;

sfnp = 'circle';
[XY, E, N, L] = read_gspace(sfnp);

T.m = [0; 0];   T.S = [1, 0; 0, 1];
XY.p1i = gauss2d(XY.xi, XY.yi, T.m, T.S);
XY.intp1i = intFxyWxy(XY.x,XY.y,XY.p1i);
figure(1);
for i = 1:XY.ne
    E(i).l = XY.p1i(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    E(i).h = patch(E(i).xy(:,1), E(i).xy(:,2), 10*E(i).l', E(i).l');
end
axis equal;     axis off;   colorbar;   pause;

u1min = 2000/60/pi;   u1max = 8000/60/pi;   nu1 = 50;
u2min = -pi/3;   u2max = pi/3;   nu2 = 50;
U = create_space2d(u1min, u1max, nu1, u2min, u2max, nu2);
um = [6000/60/pi; 0];   uS = [3000/60/pi, 0; 0, pi/20];
U.pi = gauss2d(U.xi, U.yi, um, uS);

FRSR = compute_pfrs_matrix(U, XY);

figure(2)
for i = 1:FRSR.nx
    for j = 1:FRSR.ny
        EFRS(i,j) = create_patch([FRSR.x(i),FRSR.y(j)],[XY.dx/2,XY.dy/2]);
        patch(EFRS(i,j).xy(:,1), EFRS(i,j).xy(:,2),...
            10*FRSR.pi(i,j)*ones(QUAD,1), FRSR.pi(i,j)*ones(QUAD,1));
    end
end
axis equal;     axis off;   colorbar;
pause;

XY.p2i = predict2d(XY.dx, XY.dy, FRSR.pi, XY.p1i);
XY.intp2i = intFxyWxy(XY.x,XY.y,XY.p2i);
figure(1);
for i = 1:XY.ne
    E(i).l = XY.p2i(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    set(E(i).h, 'zdata', 10*E(i).l', 'cdata', E(i).l');
end
