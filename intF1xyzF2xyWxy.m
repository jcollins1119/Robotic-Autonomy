% intF1xyzF2xyWxy.m programmed by Tomo Furukawa
function Fz = intF1xyzF2xyWxy(x, y, f1xyz, f2xy)

nx = length(x);
ny = length(y);

for i = 1:nx
    for j = 1:ny
        f1xy(:,:) = f1xyz(i,j,:,:);
        fxyz = f1xy .* f2xy;
        Fz(i,j) = intFxyWxy(x, y, fxyz);
    end
end

