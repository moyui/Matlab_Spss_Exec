function [d] = distance(a,b);%//求a,b两点间的距离
a=a*pi/180;%转化为弧度
b=b*pi/180;
d=6371*acos(cos(a(1)-b(1))*cos(a(2))*cos(b(2))+sin(a(2))*sin(b(2)));