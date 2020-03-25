% test_vpfov_likelihood.m programmed by Tomo Furukawa
clear all;
close all;
% 
% S_x_min = -4;  S_x_max = 4;  nx = 80;
% S_y_min = -3; S_y_max = 3;    ny = 60;
% FoV = create_space2d(S_x_min, S_x_max, nx, S_y_min, S_y_max, ny);
d_min = .105;  d_max = 10;  nd = 40;
p_min = -43.5*pi/180; p_max = 43.5*pi/180;    np = 80;
FoV = create_space2d(d_min, d_max, nd, p_min, p_max, np);
% FoV.PoDi = PoDvcamera(FoV.x, FoV.y);
% dc_min = 1.5;   dc_max = 4.5;
dc_min = 1;   dc_max = 8;
w = 7;
%% Calculate Probability field
for i = 1:np
    FoV.PoDi(:,i) = 1./(exp(-w*(FoV.x-dc_min))+1)-1./(exp(-w*(FoV.x-dc_max))+1);
end
%%
% 
% S.x = [2, 1, -5*pi/12];
S.x = [0 0 0];


[S_xi, S_yi] = hfov(FoV.xi, FoV.yi);
for i = 1:nd
    for j = 1:np
%         y = transform_p2d([FoV.xi(i,j), FoV.yi(i,j)], S.x);
          y = transform_p2d([S_xi(i,j), S_yi(i,j)], S.x);  %Transform space 
        S.xi(i,j) = y(1); S.yi(i,j) = y(2);
    end
end

% T.z = [6, 3];
% T.z = [4, -1];
T.z = [-1 , 0]; 
[S.li, T.detectFlag] = JC_likelihood_depth(FoV.xi, FoV.yi, FoV.PoDi, S.x, T.z);

surf(S.xi, S.yi, S.li);   shading interp; axis equal;
xlabel('x');    ylabel('y');     zlabel('PoD');
pause;
view(2);
