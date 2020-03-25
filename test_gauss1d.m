% test_gauss1d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
X = create_space1d(xmin, xmax, nx);

m = 0;   S = 5;
X.p = gauss1d(X.x, m, S);

plot(X.x, X.p);
