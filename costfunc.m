function fx = costfunc(x,y)
fx = (x - 3.14)^2 + (y - 2.72)^2 + sin(3*x + 1.41) + sin(4*y - 1.73);
fx = -fx;
end