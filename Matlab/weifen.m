clc,clear
yx=@(x,y)-2*y+2*x^2+2*x;
[x,y]=ode45(yx,[0,0.5],1)
sol=ode45(yx,[0,0.5],1)
y2=deval(sol,x)
check=[y,y2']