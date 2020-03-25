clear all;
close all;

global N;
global E;
global XY;

T(1).xm = 0;
T(1).ym = 0;
T(1).xv = 1;
T(1).yv = 1;

XY.dtype = 0;   % 0: Grid-based, 1: Element-based
XY.btype = 'd'; % 'c': Circular, 'd': Diamond
%%%% If dtype is 1, then ntype and etype have to be specified %%%%
XY.ntype = 0;   % 0: Rectangular, 1: Random
XY.etype = 1;   % 0: Triangular, 1: Quadrilateral
XY.gtype = 1;   % 0: Lattice, 1: Triangular
XY.noptFlag = 0;   % 0: No optimization, 1: Optimization
if XY.dtype == 0
    XY.vertices = 4;
else
    if XY.etype == 0
        XY.vertices = 3;
    else
        XY.vertices = 4;
    end
end

disp('Defining boundary');
%[XY, B] = read_boundary('circle', XY);
if XY.btype == 'c'
    BT.r = 5;
    BT.nth = 100;
    BT.dth = 2*pi/BT.nth;
    BT.xc = 0;
    BT.yc = 0;
    BT.A = BT.r^2 * pi;
elseif XY.btype == 'd'
    BT.lx = 5;
    BT.nx = 100;
    BT.dx = BT.lx/BT.nx;
    BT.xc = 0;
    BT.yc = 0;
    BT.A = BT.lx^2;
end
[XY.x_bt, XY.y_bt] = define_boundary(XY.btype, BT);
XY.x_min = min(XY.x_bt);
XY.x_max = max(XY.x_bt);
XY.y_min = min(XY.y_bt);
XY.y_max = max(XY.y_bt);
if XY.btype == 'c'
    XY.btnodes = BT.nth;
elseif XY.btype == 'd'
    XY.btnodes = BT.nx;
end
for i = 1:XY.btnodes
    B(i).xy(1) = XY.x_bt(i);
    B(i).xy(2) = XY.y_bt(i);
end

disp('Generating mesh');
disp('* Creating grid');
XY.nx = 30;
if XY.btype == 'c'
    XY.dx = (XY.x_max - XY.x_min) / XY.nx;
elseif XY.btype == 'd'
    XY.dx = XY.x_max / XY.nx;
end

if XY.btype == 'c'
    BA.r = BT.r;
    BA.dth = XY.dx / BT.r;
    BA.nth = ceil(2*pi/BA.dth);
    BA.xc = BT.xc;
    BA.yc = BT.yc;
    [XY.x_b, XY.y_b] = define_boundary(XY.btype, BA);
    XY.bnodes = BA.nth;
elseif XY.btype == 'd'
    BA.lx = BT.lx;
    BA.nx = XY.nx;
    BA.dx = BA.lx / BA.nx;
    BA.xc = BT.xc;
    BA.yc = BT.yc;
    [XY.x_b, XY.y_b] = define_boundary(XY.btype, BA);
    XY.bnodes = 4*BA.nx;
end

XY.x_off = XY.dx*0.5;
XY.x_r = [XY.x_min+XY.x_off:XY.dx:XY.x_max-XY.x_off];
if (XY.dtype == 1) && (XY.etype == 0) % Element-based / Triangular
    XY.dy = 0.5*sqrt(3)*XY.dx;
    XY.ny = floor((XY.y_max - XY.y_min)/XY.dy);
else
    XY.ny = XY.nx;
    if XY.btype == 'c'
        XY.dy = (XY.y_max - XY.y_min) / XY.ny;
    elseif XY.btype == 'd'
        XY.dy = XY.y_max / XY.ny;
    end
end
XY.y_off = XY.dy*0.5;
XY.y_r = [XY.y_min+XY.y_off:XY.dy:XY.y_max-XY.y_off];
if XY.btype == 'c'
    J = XY.ny;
    I = XY.nx;
elseif XY.btype == 'd'
    if (XY.dtype == 1) && (XY.etype == 0) % Element-based Triangular
        J = XY.ny;
    else
        J = 2*XY.ny;
    end
    I = 2*XY.nx;
end
    
if XY.ntype == 0 % Inner nodes are allocated on a grid basis
    
    disp('* Selecting inner nodes');
    count = 0;
    for j = 1:J
        for i = 1:I
            if (XY.dtype == 1) && (XY.etype == 0) % Element-based Triangular
                if mod(j,2) == 1
                    x2 = XY.x_r(i) + 0.5*XY.dx;
                else
                    x2 = XY.x_r(i);
                end
            else
                x2 = XY.x_r(i);
            end
            if XY.btype == 'c'
                XY.sFlag(i,j) = check_inside([x2, XY.y_r(j)], B, XY.btnodes);
            elseif XY.btype == 'd'
                if abs(x2)+abs(XY.y_r(j)) <= BT.lx/sqrt(2) + 1e-6
                    XY.sFlag(i,j) = 1;
                else
                    XY.sFlag(i,j) = 0;
                end
            end
            if XY.sFlag(i,j) == 1
                count = count + 1;
                XY.x_s(count) = x2;
                XY.y_s(count) = XY.y_r(j);
                if (XY.dtype == 1) && (XY.etype == 0)
                else
                    C(count).index = [i, j];
                end
            end
        end
    end
    XY.snodes = count;

    % Defining rectangular space for true approximate space
    disp('* Defining rectangular space');
    if XY.btype == 'c'
        XY.nx_t = BT.nth;
    elseif XY.btype == 'd'
        XY.nx_t = BT.nx;
    end
    XY.dx_t = (XY.x_max - XY.x_min) / XY.nx_t;
    XY.x_off_t = XY.dx_t*0.5;
    XY.x_r_t = [XY.x_min+XY.x_off_t:XY.dx_t:XY.x_max-XY.x_off_t];
    XY.ny_t = XY.nx_t;
    XY.dy_t = (XY.y_max - XY.y_min) / XY.ny_t;
    XY.y_off_t = XY.dy_t*0.5;
    XY.y_r_t = [XY.y_min+XY.y_off_t:XY.dy_t:XY.y_max-XY.y_off_t];

    % Calculate approximate area
    disp('* Calculating approximate area');
    if (XY.dtype == 1) && (XY.etype == 0) % Element-based Triangular
        for i = 1:XY.bnodes
            %N(i).xy = B(i).xy;
            N(i).xy = [XY.x_b(i), XY.y_b(i)];
            N(i).bFlag = 1;
            XY.x_n(i) = XY.x_b(i);
            XY.y_n(i) = XY.y_b(i);
        end
        XY.inodes = XY.snodes;
        XY.nodes = XY.bnodes + XY.inodes;
        XY.snodes = XY.nodes; %%%
        for i = 1:XY.inodes
            x(i) = XY.x_s(i);
            y(i) = XY.y_s(i);
            N(i).bFlag = 0;
        end
        if XY.noptFlag == 0
            mesh_func([x, y]);
        else
            X0 = [x, y];
            options = optimset('display', 'iter');
            X = fminunc(@mesh_func, X0, options);
        end
    else % Grid/Quad
        XY.cells = XY.snodes;
        XY.nodes = XY.snodes;
        XY.elems = XY.snodes;
        for i = 1:XY.cells
            C(i).xyc(1) = XY.x_r(C(i).index(1));
            C(i).xyc(2) = XY.y_r(C(i).index(2));
            xm = C(i).xyc(1)-XY.x_off;
            ym = C(i).xyc(2)-XY.y_off;
            xp = C(i).xyc(1)+XY.x_off;
            yp = C(i).xyc(2)+XY.y_off;
            C(i).xy(1,1) = xm;
            C(i).xy(1,2) = ym;
            C(i).xy(2,1) = xp;
            C(i).xy(2,2) = ym;
            C(i).xy(3,1) = xp;
            C(i).xy(3,2) = yp;
            C(i).xy(4,1) = xm;
            C(i).xy(4,2) = yp;
            if (XY.dtype == 1) && (XY.etype == 1)
                pp = XY.dx/2;
                if abs(C(i).xy(1,1))+abs(C(i).xy(1,2)) > BT.lx/sqrt(2) + XY.dx/4
                    C(i).xy(1,1) = C(i).xy(1,1) + pp;
                    C(i).xy(1,2) = C(i).xy(1,2) + pp;
                end
                if abs(C(i).xy(2,1))+abs(C(i).xy(2,2)) > BT.lx/sqrt(2) + XY.dx/4
                    C(i).xy(2,1) = C(i).xy(2,1) - pp;
                    C(i).xy(2,2) = C(i).xy(2,2) + pp;
                end
                if abs(C(i).xy(3,1))+abs(C(i).xy(3,2)) > BT.lx/sqrt(2) + XY.dx/4
                    C(i).xy(3,1) = C(i).xy(3,1) - pp;
                    C(i).xy(3,2) = C(i).xy(3,2) - pp;
                end
                if abs(C(i).xy(4,1))+abs(C(i).xy(4,2)) > BT.lx/sqrt(2) + XY.dx/4
                    C(i).xy(4,1) = C(i).xy(4,1) + pp;
                    C(i).xy(4,2) = C(i).xy(4,2) - pp;
                end
            end
        end
        for i = 1:XY.cells
            for j = 1:XY.vertices
                XY.x_e(j,i) = C(i).xy(j,1);
                XY.y_e(j,i) = C(i).xy(j,2);
            end
        end
        XY.A = XY.dx * XY.dy * XY.cells;
        
    end
    fpr = fopen('space.gdt','w');
    fprintf(fpr, 'x: ');
    fprintf(fpr, '%f %f\n', XY.x_min, XY.x_max);
    fprintf(fpr, 'nx: ');
    if XY.btype == 'd'
        fprintf(fpr, '%d\n', 2*XY.nx);
    else
        fprintf(fpr, '%d\n', XY.nx);
    end
    fprintf(fpr, 'y: ');
    fprintf(fpr, '%f %f\n', XY.y_min, XY.y_max);
    fprintf(fpr, 'ny: ');
    if XY.btype == 'd'
        fprintf(fpr, '%d\n', 2*XY.ny);
    else
        fprintf(fpr, '%d\n', XY.ny);
    end
    fprintf(fpr, 'n: ');
    fprintf(fpr, '%d\n', XY.nodes);
    for i = 1:XY.nodes
        fprintf(fpr, '%d: ', i);
        fprintf(fpr, '%d %d\n', C(i).index(1), C(i).index(2));
    end
    fclose(fpr);
    
else % Element-based method with random inner nodes
    for i = 1:XY.bnodes
        N(i).xy = B(i).xy;
        N(i).bFlag = 1;
        XY.x_n(i) = XY.x_b(i);
        XY.y_n(i) = XY.y_b(i);
    end
    
    XY.inodes = 30;
    XY.nodes = XY.inodes + XY.bnodes;

    % Non-grid node generation
    count = XY.bnodes;
    while(1)
        c_xy(1) = (XY.x_max-XY.x_min)*rand + XY.x_min;
        c_xy(2) = (XY.y_max-XY.y_min)*rand + XY.y_min;
        
        % Check if nodes are inside the space
        inFlag = check_inside(c_xy, N, XY.bnodes);
        if inFlag == 1
            count = count + 1;
            N(count).xy = c_xy;
            N(count).bFlag = 0;
            x(count) = N(count).xy(1);
            y(count) = N(count).xy(2);
        end
        if count == XY.nodes
            break;
        end
    end
    
    % Remesh
    X0 = [x(XY.bnodes+1:XY.nodes), y(XY.bnodes+1:XY.nodes)];
    if XY.noptFlag == 0
        mesh_func(X0);
    else
        %options = optimset('fminunc');
        %options = optimset('display', 'iter', 'maxiter', 20);
        %options = optimset('display', 'iter', 'maxiter', 20, 'maxfunevals', 800);
        options = optimset('display', 'iter');
        X = fminunc(@mesh_func, X0, options);
    end
end

