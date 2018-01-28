clc,clear
a=[1,0;1,1;3,2;4,3;2,5];
[m,n]=size(a);
d=zeros(m);
d=mandist(a');
d=tril(d);
nd=nonzeros(d);
nd=union([],nd)
for i=1:m-1
    nd_min=min(nd);
    [row,col]=find(d==nd_min);tm=union(row,col);
    tm=reshape(tm,1,length(tm));
    fprintf('第%d次合成，平台高度%d时的分类结果为：%s\n',i,nd_min,int2str(tm));
    nd(nd==nd_min)=[];
    if length(nd)==0
        break
    end
end