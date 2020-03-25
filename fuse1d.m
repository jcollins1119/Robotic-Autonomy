% fuse1d.m programmed by Tomo Furukawa
function [lxkGzk, S] = fuse1d(x, nx, S, ns)

lxkGzk = ones(1, nx+1);
for i = 1:ns % lxkGzk(xk|zk)
    %S(i).lxkGzk = create_likelihood1d(x, S(i));
    S(i).lxkGzk = create_likelihood1dwFoV(x, S(i));
    lxkGzk = lxkGzk .* S(i).lxkGzk;
end
