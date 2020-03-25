% test_mpredict2d.m programmed by Tomo Furukawa
clear all;
close all;
global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;   nk = 10;

sfnp = 'circle';
[XY, E, N, L] = read_gspace(sfnp);

T.m = [0; 0];   T.S = [1, 0; 0, 1];
XY.p1i = gauss2d(XY.xi, XY.yi, T.m, T.S);
figure(1);
for i = 1:XY.ne
    E(i).l = XY.p1i(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    E(i).h = patch(E(i).xy(:,1), E(i).xy(:,2), 10*E(i).l', E(i).l');
end
axis equal;     axis off;   colorbar;   pause;

u1min = 2000/60/pi;   u1max = 8000/60/pi;   nu1 = 50;
u2min = -pi/3;   u2max = pi/3;   nu2 = 50;
U = create_space2d(u1min, u1max, nu1, u2min, u2max, nu2);
um = [6000/60/pi; 0];   uS = [3000/60/pi, 0; 0, pi/10];
U.pi = gauss2d(U.xi, U.yi, um, uS);
FRSR = compute_pfrs_matrix(U, XY);

for k = 1:nk
    XY.p2i = predict2d(XY.dx, XY.dy, FRSR.pi, XY.p1i);
    XY.p2i = normFxyWxy(XY.x, XY.y, XY.p2i);
    for i = 1:XY.ne
        E(i).l = XY.p2i(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
        set(E(i).h, 'zdata', 10*E(i).l', 'cdata', E(i).l');
    end
    pause;
    XY.p1i = XY.p2i;
end