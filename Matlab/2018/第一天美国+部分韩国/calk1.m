clc,clear
p0=10^11;
tic
y=120;
w1=[75 100];
nd1=[1 2];
ns1=[6 8 10];
w1s = w1';
ndf=reshape(w1s*nd1, 1, 4);
nsf=y*ns1;
rand('state',sum(clock));
for i=1:10^6
    m=randi([0,10^4],1,2);
    n=randi([0,10^4],1,2);
 a= m(1)>n(1);
 b = m(2)<n(2);
    if (a==0 || b==0)
        continue;
    end
    nd=0;ns=0;
    nd(1)=sum(ndf(randi([1,4],1,m(1))));
    nd(2)=sum(ndf(randi([1,4],1,m(2))));
    ns(1)=sum(nsf(randi([1,3],1,n(1))));
    ns(2)=sum(nsf(randi([1,3],1,n(2))));
    [f,g]=mengtk1(m,n,nd,ns);
    if all(g <= 0)
        if p0 > f
            l1=m;l2=n;p0=f;
        end
    end
end
l1,l2,p0
toc