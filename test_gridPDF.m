% test_gridPDF.m programmed by Tomo Furukawa
clear all;
close all;

global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;
sfnp = 'circle';

[XY, E, N, L] = read_gspace(sfnp);

m = [0; 0];   S = [1, 0; 0, 1];
XY.pi = gauss2d(XY.xi, XY.yi, m, S);

for i = 1:XY.ne
    E(i).p = XY.pi(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    patch(E(i).xy(:,1), E(i).xy(:,2), 10*E(i).p', E(i).p');
end
axis equal;     axis off;
