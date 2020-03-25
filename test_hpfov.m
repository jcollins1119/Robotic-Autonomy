% test_hpfov.m programmed by Tomo Furukawa
clear all;
close all;

d_min = .105;  d_max = 10;  nd = 10;
p_min = -43.5; p_max = 43.5;    np = 20;
FoV = create_space2d(d_min, d_max, nd, p_min, p_max, np);

dc_min = 1.5;   dc_max = 4.5;
w = 7;
for i = 1:np
    FoV.pi(:,i) = 1./(exp(-w*(FoV.x-dc_min))+1)-1./(exp(-w*(FoV.x-dc_max))+1);
end
surf(FoV.xi, FoV.yi, FoV.pi);   shading interp; 
xlabel('d');    ylabel('\phi');     zlabel('PoD');
%view(2);
pause;

S.x = 2;    S.y = 1;    S.th = -5*pi/12;
[S_xi, S_yi] = hfov(FoV.xi, FoV.yi);
for i = 1:nd
    for j = 1:np
        y = transform_p2d([S_xi(i,j), S_yi(i,j)], [S.x, S.y, S.th]);
        S.xi(i,j) = y(1); S.yi(i,j) = y(2);
    end
end
surf(S.xi, S.yi, FoV.pi);   shading interp; axis equal;
xlabel('x');    ylabel('y');     zlabel('PoD');
%view(2);    