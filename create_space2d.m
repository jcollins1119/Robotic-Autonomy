% create_space2d.m programmed by Tomo Furukawa
function XY = create_space2d(xmin, xmax, nx, ymin, ymax, ny)

XY.dx = (xmax - xmin)/nx;
XY.dy = (ymax - ymin)/ny;

XY.xmin = xmin + XY.dx/2;
XY.xmax = xmax - XY.dx/2;
XY.nx = nx;
XY.ymin = ymin + XY.dy/2;
XY.ymax = ymax - XY.dy/2;
XY.ny = ny;

XY.x = XY.xmin:XY.dx:XY.xmax;
XY.y = XY.ymin:XY.dy:XY.ymax;

[XY.xi, XY.yi] = meshgrid(XY.x, XY.y);
XY.xi = XY.xi';
XY.yi = XY.yi';
