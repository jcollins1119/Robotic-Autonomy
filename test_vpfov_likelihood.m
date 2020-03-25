% test_vpfov_likelihood.m programmed by Tomo Furukawa
clear all;
close all;

S_x_min = -4;  S_x_max = 4;  nx = 80;
S_y_min = -3; S_y_max = 3;    ny = 60;
FoV = create_space2d(S_x_min, S_x_max, nx, S_y_min, S_y_max, ny);
FoV.PoDi = PoDvcamera(FoV.x, FoV.y);

S.x = [2, 1, -5*pi/12];
for i = 1:nx
    for j = 1:ny
        y = transform_p2d([FoV.xi(i,j), FoV.yi(i,j)], S.x);
        S.xi(i,j) = y(1); S.yi(i,j) = y(2);
    end
end

%T.z = [6, 3];
T.z = [4, -1];
%T.z = [2, 1];
[S.li, T.detectFlag] = likelihood_vcamera(FoV.xi, FoV.yi, FoV.PoDi, S.x, T.z);

surf(S.xi, S.yi, S.li);   shading interp; axis equal;
xlabel('x');    ylabel('y');     zlabel('PoD');
pause;
view(2);
