a=textread('carsown.txt');%load data and years
x=a(:,2);%data
t=[2006:1:2016]';%years
t0=t(1);x0=x(1);%initial value
fun=@(cs,td)cs(1)./(1+((cs(1)/x0)-1)*exp(-cs(2)*(td-t0)));%cs(1)=xm,cs(2)=r;logistic regression
cs=lsqcurvefit(fun,rand(2,1),t(2:end),x(2:end),zeros(2,1))%NLS estimate
tw=[2020:1:2050];%perdiction years
xhat=fun(cs,tw);%result

