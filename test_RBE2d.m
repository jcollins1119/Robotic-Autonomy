% test_RBE2d.m programmed by Tomo Furukawa
clear all;
close all;
global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;   nk = 10;

sfnp = 'space';
[XY, E, N, L] = read_gspace(sfnp);

S.x = [-5, 0, 0];   T.x = [3, 1];
T.m = [0; 0];   T.S = [1, 0; 0, 1];
XY.p1i = gauss2d(XY.xi, XY.yi, T.m, T.S);
figure(1);
for i = 1:XY.ne
    E(i).l = XY.p1i(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
    E(i).h = patch(E(i).xy(:,1), E(i).xy(:,2), E(i).l', E(i).l');
end
axis square;     axis off;   colorbar;   hold on; 
S.h = plot3(S.x(1), S.x(2), 1, 'ro'); pause;

FRSR = create_pfrs_matrix([2000/60/pi, -pi/3], [8000/60/pi, pi/3],...
    [50, 50],[6000/60/pi; 0], [3000/60/pi, 0; 0, pi/10], XY);
FoV = create_space2d(-1, 1, 5, -2, 2, 10);
FoV.PoDi = PoDvcamera(FoV.x, FoV.y);

for k = 1:nk
    XY.p2i = predict2d(XY.dx, XY.dy, FRSR.pi, XY.p1i);

    S.x(1) = S.x(1) + 1;
    ST.z = T.x;
    
    [XY.li, T.detectFlag] = compute_likelihood_vcamera(FoV, XY, S.x, ST.z);
    XY.p2i = correct2d(XY.x, XY.y, XY.p2i, XY.li);
    
    for i = 1:XY.ne
        E(i).l = XY.p2i(E(i).index(1),E(i).index(2))*ones(1,E(i).nn);
        set(E(i).h, 'zdata', 10*E(i).l', 'cdata', E(i).l');
    end
    set(S.h, 'xdata', S.x(1)');     pause;
    XY.p1i = XY.p2i;
end