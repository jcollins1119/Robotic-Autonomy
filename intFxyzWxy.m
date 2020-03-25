% intFxyzWxy.m programmed by Tomo Furukawa
function Fz = intFxyzWxy(x, y, fxyz)

nx = length(x);
ny = length(y);

for i = 1:ny
    for j = 1:nx
        Fz(i,j) = intFxyWxy(x, y, fxyz(:,:,i,j));
    end
end
