f=[-3;-2;-1];
intcon =3;
a=ones(1,3);b=7;
aeq=[4 2 1];beq=12;
lb=zeros(3,1);ub=[inf;inf;1];
[f,x]=intlinprog(f,intcon,a,b,aeq,beq,lb,ub)
