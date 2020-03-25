% compute_pfrs_matrix.m programmed by Tomo Furukawa
function FRSR = compute_pfrs_matrix(U, XY)

dt = 0.2;   nk = 10;    l = 0;
for i = 1:U.nx+1
    for j = 1:U.ny+1
        x = 0;  y = 0;  th = 0;
        for k = 1:nk
            [dx, dy, dth] = ackerman(x, y, th, U.x(i), U.y(j));
            x = x + dt * dx;
            y = y + dt * dy;
            th = th + dt * dth;
        end
        FRS.xi(i,j) = x;  FRS.yi(i,j) = y;
        l = l + 1;  FRS.x(l) = x;    FRS.y(l) = y;    FRS.p(l) = U.pi(i,j);
    end
end
FRS.xmin = min(min(FRS.xi));  FRS.xmax = max(max(FRS.xi));
FRS.ymin = min(min(FRS.yi));  FRS.ymax = max(max(FRS.yi));

nmx = floor(FRS.xmin/XY.dx);    npx = ceil(FRS.xmax/XY.dx);
nmy = floor(FRS.ymin/XY.dy);    npy = ceil(FRS.ymax/XY.dy);
nx = abs(nmx) + abs(npx) + 1;   ny = abs(nmy) + abs(npy) + 1;
xmin = (nmx - 0.5) * XY.dx;     xmax = (npx + 0.5) * XY.dx;
ymin = (nmy - 0.5) * XY.dy;     ymax = (npy + 0.5) * XY.dy;
l = (U.nx+1)*(U.ny+1);
FRS.x(l+1) = xmin;    FRS.y(l+1) = ymin;    FRS.p(l+1) = 0;
FRS.x(l+2) = xmax;    FRS.y(l+2) = ymin;    FRS.p(l+2) = 0;
FRS.x(l+3) = xmin;    FRS.y(l+3) = ymax;    FRS.p(l+3) = 0;
FRS.x(l+4) = xmax;    FRS.y(l+4) = ymax;    FRS.p(l+4) = 0;

FRSR = create_space2d(xmin, xmax, nx, ymin, ymax, ny);
FRSR.xq = FRSR.xmin+0.5*XY.dx:XY.dx:FRSR.xmax-0.5*XY.dx;
FRSR.yq = FRSR.ymin+0.5*XY.dy:XY.dy:FRSR.ymax-0.5*XY.dy;
[FRSR.xqi, FRSR.yqi] = meshgrid(FRSR.xq, FRSR.yq);
FRSR.xqi = FRSR.xqi';     FRSR.yqi = FRSR.yqi';
pxyqi = griddata(FRS.x, FRS.y, FRS.p, FRSR.xqi, FRSR.yqi);
FRSR.pqi = normFxyWxy(FRSR.xq, FRSR.yq, pxyqi);