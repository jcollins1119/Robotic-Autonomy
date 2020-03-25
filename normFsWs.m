% normFsWs.m programmed by Tomo Furukawa
function normpi = normFsWs(XY, U)

XYR = create_space2d(XY.xmin, XY.xmax, XY.nx, XY.ymin, XY.ymax, XY.ny);

l = (U.nx+1)*(U.ny+1);
XY.x(l+1) = XY.xmin;    XY.y(l+1) = XY.ymin;    XY.p(l+1) = 0;
XY.x(l+2) = XY.xmax;    XY.y(l+2) = XY.ymin;    XY.p(l+2) = 0;
XY.x(l+3) = XY.xmin;    XY.y(l+3) = XY.ymax;    XY.p(l+3) = 0;
XY.x(l+4) = XY.xmax;    XY.y(l+4) = XY.ymax;    XY.p(l+4) = 0;

XYR.pi = griddata(XY.x, XY.y, XY.p, XYR.xi, XYR.yi);
normpi = U.pi / intFxyWxy(XYR.x, XYR.y, XYR.pi);
surf(XYR.xi, XYR.yi, XYR.pi);
pause;