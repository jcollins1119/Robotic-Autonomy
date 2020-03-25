% create_space1d.m programmed by Tomo Furukawa
function X = create_space1d(xmin, xmax, nx)

dx = (xmax - xmin)/nx;

X.xmin = xmin + dx/2;
X.xmax = xmax - dx/2;
X.nx = nx;

X.x = X.xmin:dx:X.xmax;   % Sample points for integration

