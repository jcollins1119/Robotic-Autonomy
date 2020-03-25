% normF1xyzF2xyWxy.m programmed by Tomo Furukawa
function Fxy = normF1xyzF2xyWxy(x, y, f1xyz, f2xy)

nx = length(x);
ny = length(y);

for i = 1:ny
    for j = 1:nx
        Fxy(:,:,i,j) = normF1xyF2xyWxy(x, y, f1xyz(:,:,i,j), f2xy);
    end
end
