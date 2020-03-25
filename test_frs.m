% test_frs.m programmed by Tomo Furukawa
clear all;
close all;

dt = 0.2;
nk = 10;
% Create control space
u1min = 2000/60/pi;   u1max = 8000/60/pi;   nu1 = 20;
u2min = -pi/6;   u2max = pi/6;   nu2 = 20;
%u1min = 0/60/pi;   u1max = 2000/60/pi;   nu1 = 20;
%u2min = 0/60/pi;   u2max = 2000/60/pi;   nu2 = 20;
U = create_space2d(u1min, u1max, nu1, u2min, u2max, nu2);

plot(0, 0, 'o');  axis equal; 
hold on;

for i = 1:nu1
    for j = 1:nu2
        x = 0;  y = 0;  th = 0;
        u1 = U.x(i);    u2 = U.y(j);
        for k = 1:nk
            [dx, dy, dth] = ackerman(x, y, th, u1, u2);
            %[dx, dy, dth] = differential(x, y, th, u1, u2);
            x = x + dt * dx;
            y = y + dt * dy;
            th = th + dt * dth;
        end
        xkpc(j,i) = x;  ykpc(j,i) = y;
    end
end

plot(xkpc, ykpc, '.');
plot(xkpc(1,:), ykpc(1,:), '-')
plot(xkpc(:,1), ykpc(:,1), '-')
plot(xkpc(nu1,:), ykpc(nu1,:), '-')
plot(xkpc(:,nu2), ykpc(:,nu2), '-')
xlabel('x');    ylabel('y');
