% test_RBE2d_GM.m programmed by Tomo Furukawa
clear all;
close all;
global XY;  global ON;  global OFF; global QUAD;
OFF = 0;    ON = 1; QUAD = 4;   nk = 10;

sfnp = 'space';
[XY, E, N, L] = read_gspace(sfnp);

S.x = [-5, 0, 0];   T.x = [3, 1];
T.m = [0; 0];   T.S = [1, 0; 0, 1];
XY.p1i = gauss2d(XY.xqi, XY.yqi, T.m, T.S);
XY.p1i_max = max(max(XY.p1i));
figure(1);
for i = 1:XY.nl
    node1 = L(i).n(1);  node2 = L(i).n(2);
    XY.xl(:,i) = [N(node1).xy(1); N(node2).xy(1)];
    XY.yl(:,i) = [N(node1).xy(2); N(node2).xy(2)];
    XY.zl(:,i) = [XY.p1i(N(node1).index(1),N(node1).index(2));
        XY.p1i(N(node2).index(1),N(node2).index(2))];
    XY.cl(i,:) = derive_cmat(XY.zl(1,i), XY.zl(2,i), XY.p1i_max);
end
S.hXY = line(XY.xl, XY.yl, XY.zl);  
axis([min(min(XY.xl)),max(max(XY.xl)),min(min(XY.yl)),max(max(XY.yl)),0,1]);
hold on;    view(3);
for i = 1:XY.nl
    set(S.hXY(i), 'color', XY.cl(i,:));
end
S.h = plot3(S.x(1), S.x(2), 1, 'ro');

FRSR = create_pfrs_matrix([2000/60/pi, -pi/3], [8000/60/pi, pi/3],...
    [50, 50],[6000/60/pi; 0], [3000/60/pi, 0; 0, pi/10], XY);
FoV = create_space2d(-1, 1, 5, -2, 2, 10);
FoV.PoDi = PoDvcamera(FoV.x, FoV.y);

for k = 1:nk
    XY.p2i = predict2d(XY.dx, XY.dy, FRSR.pqi, XY.p1i);

    S.x(1) = S.x(1) + 1;
    ST.z = T.x;

    [XY.li, T.detectFlag] = compute_likelihood_vcamera(FoV, XY, S.x, ST.z);
    XY.p2i = correct2d(XY.xq, XY.yq, XY.p2i, XY.li);

    XY.p2i_max = max(max(XY.p2i));
    for i = 1:XY.nl
        node1 = L(i).n(1);  node2 = L(i).n(2);
        XY.zl(:,i) = [XY.p2i(N(node1).index(1),N(node1).index(2)),
            XY.p2i(N(node2).index(1),N(node2).index(2))];
        XY.cl(i,:) = derive_cmat(XY.zl(1,i), XY.zl(2,i), XY.p2i_max);
        set(S.hXY(i), 'zdata', XY.zl(:,i), 'color', XY.cl(i,:));
    end
    set(S.h, 'xdata', S.x(1)');     drawnow;
    XY.p1i = XY.p2i;
end