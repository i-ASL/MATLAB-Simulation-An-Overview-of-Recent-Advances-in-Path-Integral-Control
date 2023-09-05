function [dx2] = thetaDyn(E,x1,x2,u)

g  = E.g;
mc = E.mc;
mp = E.mp;
l  = E.l;

dx2 = 1/(l*(mc+mp*sin(x1)^2))*(-u*cos(x1)-mp*l*x2^2*cos(x1)*sin(x1)-(mp+mc)*g*sin(x1));

end