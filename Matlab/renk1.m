clc,clear
a=textread('data4.txt');
x=a([2:2:6],:)';x=nonzeros(x);
t=[1790:10:2010]';
a=[ones(21,1),-x(2:end)];
b=diff(x)./x(2:end)/10;
cs=a\b;
r=cs(1),xm=r/cs(2)