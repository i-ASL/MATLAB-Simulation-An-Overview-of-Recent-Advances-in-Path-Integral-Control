function [dx4] = xDyn(E,x1,x2,u)

g  = E.g;
mc = E.mc;
mp = E.mp;
l  = E.l;

dx4  = 1/(mc+mp*sin(x1)^2)*(u+mp*sin(x1)*(l*x2^2+g*cos(x1)));

end