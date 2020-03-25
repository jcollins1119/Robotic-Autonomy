% read_gspace.m programmed by Tomo Furukawa
function [XY, E, N, L] = read_gspace(sfnp)

global XY;  global ON;  global OFF; global QUAD;

sfn = [sfnp, '.gdt'];
fps = fopen(sfn, 'r');
tmpch = fscanf(fps, '%s', 1);   
XY.xmin = fscanf(fps, '%f', 1);
XY.xmax = fscanf(fps, '%f', 1);
tmpch = fscanf(fps, '%s', 1);
XY.nx = fscanf(fps, '%d', 1);
    
tmpch = fscanf(fps, '%s', 1);
XY.ymin = fscanf(fps, '%f', 1);
XY.ymax = fscanf(fps, '%f', 1);
tmpch = fscanf(fps, '%s', 1);
XY.ny = fscanf(fps, '%d', 1);

tmpch = fscanf(fps, '%s', 1);
XY.ne = fscanf(fps, '%d', 1);
for i = 1:XY.ne
    tmpch = fscanf(fps, '%s', 1);
    cell_index(i,:) = fscanf(fps, '%d', 2);
end

XY.dx = (XY.xmax-XY.xmin)/XY.nx;   XY.dy = (XY.ymax-XY.ymin)/XY.ny;
xoff = XY.dx*0.5;  yoff = XY.dy*0.5;
XY.x = [XY.xmin:XY.dx:XY.xmax-XY.dx]+xoff;
XY.y = [XY.ymin:XY.dy:XY.ymax-XY.dy]+yoff;
[XY.xi, XY.yi] = meshgrid(XY.x, XY.y);
XY.xi = XY.xi';
XY.yi = XY.yi';

% Loop with elements
% Sort so that elements are aligned in an ascending order:
% [1,1], [2,1], [4,1], [1,2], [3,2]...
XY.cellFlag = zeros(XY.nx, XY.ny);
count = 0;
for i = 1:XY.ny
    for j = 1:XY.nx
        for k = 1:XY.ne
            if j == cell_index(k,1) & i == cell_index(k,2)
                XY.cellFlag(j,i) = ON;
                count = count + 1;
                E(count).index = [j,i];
                E(count).xyq = [XY.x(E(count).index(1)), XY.y(E(count).index(2))];
                E(count).xy(1,:) = [E(count).xyq(1)-xoff, E(count).xyq(2)-yoff];
                E(count).xy(2,:) = [E(count).xyq(1)+xoff, E(count).xyq(2)-yoff];
                E(count).xy(3,:) = [E(count).xyq(1)+xoff, E(count).xyq(2)+yoff];
                E(count).xy(4,:) = [E(count).xyq(1)-xoff, E(count).xyq(2)+yoff];
                E(count).nn = QUAD;
            end
        end
    end
end

% Loop with nodes
% Create node and line indices.  
XY.cellIndex = zeros(XY.nx, XY.ny);
count = 0;
for k = 1:XY.ne % horizontal count
    i = E(k).index(1);
    j = E(k).index(2);
    N(k).index = [i, j];
    N(k).xy = [XY.x(i), XY.y(j)];
    XY.cellIndex(i,j) = k;
    if i >= 2 & XY.cellFlag(i-1,j) == ON
        count = count + 1;
        L(count).n = [XY.cellIndex(i,j)-1, XY.cellIndex(i,j)];
    end
end
for k = 1:XY.ne % vertical count
    i = E(k).index(1);  j = E(k).index(2);
    if i >= 2 & XY.cellFlag(j,i-1) == ON
        count = count + 1;
        L(count).n = [XY.cellIndex(j,i-1), XY.cellIndex(j,i)];
    end
end
XY.nl = length(L);  XY.nn = XY.ne;

fclose(fps);
