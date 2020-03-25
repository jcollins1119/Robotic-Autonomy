% test_hfov.m programmed by Tomo Furukawa
clear all;
close all;

d_min = 1;  d_max = 5;  nd = 5;
p_min = -1.2; p_max = 1.2;    np = 10;
FoV = create_space2d(d_min, d_max, nd, p_min, p_max, np);
[S_xi, S_yi] = hfov(FoV.xi, FoV.yi);

S.x = 2;    S.y = 1;    S.th = -5*pi/12;
for i = 1:nd
    for j = 1:np
        y = transform_p2d([S_xi(i,j), S_yi(i,j)], [S.x, S.y, S.th]);
        xi(i,j) = y(1); yi(i,j) = y(2);
    end
end

plot(S.x, S.y, 'o');	axis equal;
hold on;
plot(xi, yi, '.');
plot(xi(1,:), yi(1,:), '-')
plot(xi(:,1), yi(:,1), '-')
plot(xi(nd,:), yi(nd,:), '-')
plot(xi(:,np), yi(:,np), '-')
xlabel('x');    ylabel('y');
