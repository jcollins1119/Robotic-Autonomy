function [x, y] = define_boundary(type, par)

if type == 'c'
    r = par.r;
    dth = par.dth;
    nth = par.nth;
    xc = par.xc;
    yc = par.yc;
    for i = 1:nth
        x(i) = r*cos(i*dth) + xc;
        y(i) = r*sin(i*dth) + yc;
    end
elseif type == 'd'
    lx = par.lx;
    dx = par.dx;
    nx = par.nx;
    xc = par.xc;
    yc = par.yc;
    for i = 1:nx
        x(i) = i*dx/sqrt(2) + xc;
        y(i) = i*dx/sqrt(2) - lx/sqrt(2) + yc;
    end
    for i = 1:nx
        x(i+nx) = -i*dx/sqrt(2) + lx/sqrt(2) + xc;
        y(i+nx) = i*dx/sqrt(2) + yc;
    end
    for i = 1:nx
        x(i+2*nx) = -i*dx/sqrt(2) + xc;
        y(i+2*nx) = -i*dx/sqrt(2) + lx/sqrt(2) + yc;
    end
    for i = 1:nx
        x(i+3*nx) = i*dx/sqrt(2) - lx/sqrt(2) + xc;
        y(i+3*nx) = -i*dx/sqrt(2) + yc;
    end
end
