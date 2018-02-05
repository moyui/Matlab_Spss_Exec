clc,clear
a=textread('gj.txt');
b=zscore(a);
d=pdist(b','correlation');
z=linkage(d,'average');
h=dendrogram(z);
set(h,'Color','k','LineWidth',1.3)
T=cluster(z,'maxclust',6)
for i=1:6
    tm=find(T==i);
    tm=reshape(tm,1,length(tm));
    fprintf('第%d类的有%s\n',i,int2str(tm));
end
