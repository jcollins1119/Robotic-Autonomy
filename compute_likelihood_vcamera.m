% compute_likelihood_vcamera.m programmed by Tomo Furukawa
function [li, detectFlag] = compute_likelihood_vcamera(FoV, XY, x, z)

w = 0.1;
e = 0.01;
% Observation in sensor frame
S_z = itransform_p2d(z, x);
if (S_z(1) > FoV.xmin) & (S_z(1) < FoV.xmax)...
        & (S_z(2) > FoV.ymin) & (S_z(2) < FoV.ymax)
    detectFlag = 1;
    li = zeros(XY.nx, XY.ny);
    FoV.li = gauss2d(FoV.xi, FoV.yi, S_z, [w*abs(S_z(1))+e,0;0,w*abs(S_z(2))+e]);
else
    detectFlag = 0;
    li = ones(XY.nx, XY.ny);
    FoV.li = 1 - FoV.PoDi;
end

for i = 1:XY.nx
    for j = 1:XY.ny
        S_xyq = itransform_p2d([XY.x(i),XY.y(j)], x);
        if (S_xyq(1) > FoV.xmin) & (S_xyq(1) < FoV.xmax)...
                & (S_xyq(2) > FoV.ymin) & (S_xyq(2) < FoV.ymax)
            li(i,j) = griddata(FoV.xi, FoV.yi, FoV.li,...
                S_xyq(1), S_xyq(2), 'cubic');
            li(i,j) = max(li(i,j),0);
        end
    end
end