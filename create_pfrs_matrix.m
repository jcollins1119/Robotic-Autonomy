% create_pfrs_matrix.m programmed by Tomo Furukawa
function FRSR = create_pfrs_matrix(umin, umax, nu, um, uS, XY)

u1min = umin(1);   u1max = umax(1);   nu1 = nu(1);
u2min = umin(2);   u2max = umax(2);   nu2 = nu(2);
U = create_space2d(u1min, u1max, nu1, u2min, u2max, nu2);
U.pi = gauss2d(U.xi, U.yi, um, uS);
FRSR = compute_pfrs_matrix(U, XY);
