function p = signum(v)
if norm(v) < 10^-3
    p = zeros(size(v));
else
    p = [v(1)/norm(v); v(2)/norm(v); 0];
end