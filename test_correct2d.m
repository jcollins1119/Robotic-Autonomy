% test_correct2d.m programmed by Tomo Furukawa
clear all;
close all;
global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;

sfnp = 'circle48';
[XY, E, N, L] = read_gspace(sfnp);

T.m = [0; 0];   T.S = [1, 0; 0, 1];
XY.pi = gauss2d(XY.xi, XY.yi, T.m, T.S);

S_xmin = -3;  S_xmax = 3;  nx = 10;
S_ymin = -2; S_ymax = 2;    ny = 8;
FoV = create_space2d(S_xmin, S_xmax, nx, S_ymin, S_ymax, ny);
FoV.PoDi = PoDvcamera(FoV.x, FoV.y);

S.x = [2, 1, -5*pi/12];
T.z = [6, 3];
%T.z = [4, -1];
%T.z = [2, 1];
[XY.li, T.detectFlag] = compute_likelihood_vcamera(FoV, XY, S.x, T.z);

figure(1);
for i = 1:XY.ne
    E(i).l = XY.pi(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    patch(E(i).xy(:,1), E(i).xy(:,2), 10*E(i).l', E(i).l');
end
axis equal;     axis off;
pause;

XY.pi = correct2d(XY.x, XY.y, XY.pi, XY.li);

figure(2);
for i = 1:XY.ne
    E(i).l = XY.li(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    patch(E(i).xy(:,1), E(i).xy(:,2), 10*E(i).l', E(i).l');
end
axis equal;     axis off;
pause;
figure(3);
for i = 1:XY.ne
    E(i).p = XY.pi(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    patch(E(i).xy(:,1), E(i).xy(:,2), 10*E(i).p', E(i).p');
end
axis equal;     axis off;
