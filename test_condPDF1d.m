% test_condPDF1d.m programmed by Tomo Furukawa
clear all;
close all;

xmin = -10;   xmax = 10;   nx = 100;
X = create_space1d(xmin, xmax, nx);

mx2Gx1 = 3; Sx2Gx1 = 0.8;
for i = 1:nx % px2Gx1(x2|x1)
    px2Gx1(:,i) = gauss1d(X.x, X.x(i)+mx2Gx1, Sx2Gx1);
end

figure(1)
[X.x1i, X.x2i] = meshgrid(X.x, X.x);
surf(X.x1i, X.x2i, px2Gx1);
axis([X.xmin, X.xmax, X.xmin, X.xmax]);
xlabel('x_1');  ylabel('x_2');
shading interp; colorbar;
pause;

mx1 = 0.;   Sx1 = 1.5;
X.px1 = gauss1d(X.x, mx1, Sx1);

X.px2 = intF1xzF2xWx(X.x, px2Gx1, X.px1);

plot(X.x, X.px1);
hold on;
plot(X.x, X.px2, 'r');
xlabel('x');    ylabel('p');
legend('p(x_1)', 'p(x_2)')