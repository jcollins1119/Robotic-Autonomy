% PoDvcamera.m programmed by Tomo Furukawa
function pi = PoDvcamera(x, y)

xc_min = -3.5;   xc_max = 3.5;
yc_min = -2.5;   yc_max = 2.5;
w = 7;

nx = length(x);
ny = length(y);
for i = 1:ny
    fxi(:,i) = 1./(exp(-w*(x-xc_min))+1)-1./(exp(-w*(x-xc_max))+1);
end
for i = 1:nx
    fyi(i,:) = 1./(exp(-w*(y-yc_min))+1)-1./(exp(-w*(y-yc_max))+1);
end
pi = (fxi + fyi)/2;
