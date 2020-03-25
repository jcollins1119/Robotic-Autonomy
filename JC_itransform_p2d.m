% itransform_p2d.m programmed by Tomo Furukawa
function y = JC_itransform_p2d(x, a)
%x is the target location
%a is the platform location

x_t = a(1); y_t = a(2); th_t = a(3);
z_in = [x(1); x(2); 1];

T = [cos(th_t), -sin(th_t), x_t;
   sin(th_t), cos(th_t), y_t;
   0, 0, 1];
invT = inv(T);

z_out = invT * z_in;

%Return angle as the second value instead of other

y(1) = z_out(1);    y(2) = atan2(z_out(2),z_out(1));
