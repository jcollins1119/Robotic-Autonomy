% normFxyzWxy.m programmed by Tomo Furukawa
function normfxyz = normFxyzWx(x, y, fxyz)

nx = length(x);
ny = length(y);

for i = 1:ny
    for j = 1:nx
        normfxyz(:,:,i,j) = normFxyWxy(x, y, fxyz(:,:,i,j));
    end
end
