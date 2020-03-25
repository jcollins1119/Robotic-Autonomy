% test_pfrs_rand.m programmed by Tomo Furukawa
clear all;
close all;

dt = 0.2;   nk = 10;
w1min = -5;   w1max = 5;   nw1 = 50;
w2min = -5;   w2max = 5;   nw2 = 50;
W = create_space2d(w1min, w1max, nw1, w2min, w2max, nw2);
wm = [0; 0];    wS = [5, 0; 0, 5];
W.pi = gauss2d(W.xi, W.yi, wm, wS);
u1 = 5;     u2 = pi/6;

surf(W.xi, W.yi, W.pi); shading interp;
xlabel('x');    ylabel('y');
axis equal;     view(2);        pause;

for i = 1:nw1
    w1 = W.x(i);
    for j = 1:nw2
        x = 0;  y = 0;  w2 = W.y(j);
        for k = 1:nk
            [dx, dy] = random_walk(w1, w2);
%             [dx, dy] = linear_walk(u1, u2, w1, w2);
            %[dx, dy] = nonlinear_walk(u1, u2, w1, w2);
            x = x + dt * dx;
            y = y + dt * dy;
        end
        XY.xi(i,j) = x;  XY.yi(i,j) = y;	XY.y(j) = y;
    end
    XY.x(i) = x;
end

XY.pi = normFxyWxy(XY.x, XY.y, W.pi);
surf(XY.xi, XY.yi, XY.pi); shading interp;
xlabel('x');    ylabel('y');
hold on;        plot(0, 0, 'o');  
axis equal;     view(2);