y=load('water.txt');
x=load('temper.txt');
x0=x(:,1)';
x1=x(:,2)';
xa=(x0+x1)./2;
x2=20:1:40;
a1=polyfit(x0,y,1);
a2=polyfit(x1,y,1);
a3=polyfit(xa,y,1);
y1=a1(1)*x2+a1(2);
y2=a2(1)*x2+a2(2);
y3=a3(1)*x2+a3(2);
plot(x2,y1,'o',x2,y1)
hold on
plot(x2,y2,'+',x2,y2)
hold on
plot(x2,y3,'*',x2,y3)


