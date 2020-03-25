function inFlag = check_inside(c_xy, B, bnodes)

inFlag = 1;
for i = 1:bnodes
    if i == bnodes
        n_xy = B(1).xy;
    else
        n_xy = B(i+1).xy;
    end
    b_dx = n_xy(1) - B(i).xy(1);
    b_dy = n_xy(2) - B(i).xy(2);
    b = [b_dx, b_dy];
    
    c_dx = c_xy(1) - B(i).xy(1);
    c_dy = c_xy(2) - B(i).xy(2);
    c = [c_dx, c_dy];
    crs = b(1)*c(2) - b(2)*c(1);
    if crs < 0
        inFlag = 0;
        break;
    end
end
