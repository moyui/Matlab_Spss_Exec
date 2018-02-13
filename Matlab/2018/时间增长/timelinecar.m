clc,clear
ap=textread('people.txt');
ac=textread('carsown.txt');
xp=ap(:,2);
xc=ac(:,2);
xp=nonzeros(xp);
xc=nonzeros(xc);
t=[2006:1:2016]';
t0=t(1);xp0=xp(1);xc0=xc(1);
funp=@(cs,td)cs(1)./(1+((cs(1)/xp0)-1)*exp(-cs(2)*(td-t0)));%cs(1)=xm,cs(2)=r;
func=@(cs,td)cs(1)./(1+((cs(1)/xc0)-1)*exp(-cs(2)*(td-t0)));%cs(1)=xm,cs(2)=r;
csp=lsqcurvefit(funp,rand(2,1),t(2:end),xp(2:end),zeros(2,1));
csc=lsqcurvefit(func,rand(2,1),t(2:end),xc(2:end),zeros(2,1));
tw=[2020:1:2050];
xhatp=funp(csp,tw);
xhatc=func(csc,tw);
sum=xhatp.*xhatc;
plot(tw,sum,'r')
