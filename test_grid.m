% test_grid.m programmed by Tomo Furukawa
clear all;
close all;

global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;
sfnp = 'space'; % filename prefix.  filename must have suffix .gdt

[XY, E, N, L] = read_gspace(sfnp);
for i = 1:XY.ne
    patch(E(i).xy(:,1), E(i).xy(:,2), zeros(QUAD,1), [0, 0, 1]);
end
axis equal; axis off;
