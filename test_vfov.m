% test_vfov.m programmed by Tomo Furukawa
clear all;
close all;

S_x_min = -4;  S_x_max = 4;  nx = 10;
S_y_min = -3; S_y_max = 3;    ny = 8;
FoV = create_space2d(S_x_min, S_x_max, nx, S_y_min, S_y_max, ny);

S.x = 2;    S.y = 1;    S.th = -5*pi/12;
for i = 1:nx
    for j = 1:ny
        y = transform_p2d([FoV.xi(i,j), FoV.yi(i,j)], [S.x, S.y, S.th]);
        xi(i,j) = y(1); yi(i,j) = y(2);
    end
end

plot(S.x, S.y, 'o');	axis equal;
hold on;
plot(xi, yi, '.');
plot(xi(1,:), yi(1,:), '-')
plot(xi(:,1), yi(:,1), '-')
plot(xi(nx,:), yi(nx,:), '-')
plot(xi(:,ny), yi(:,ny), '-')
xlabel('x');    ylabel('y');
