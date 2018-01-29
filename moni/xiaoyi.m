clc, clear
A=load('xiaoyi.txt');
[m,n]=size(A);
RI=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
R=rank(A);
[V,D]=eig(A);
tz=max(D);
B=max(tz);                         %最大特征值
[row, col]=find(D==B);             %最大特征值所在位置
C=V(:,col);                        %对应特征向量
CI=(B-n)/(n-1);                    %计算一致性检验指标CI
CR=CI/RI(1,n);  
if CR<0.10
    disp('CI=');disp(CI);
    disp('CR=');disp(CR);
    disp('对比矩阵A通过一致性检验，各向量权重向量Q为：');
    Q=zeros(n,1);
    for i=1:n
        Q(i,1)=C(i,1)/sum(C(:,1)); %特征向量标准化
    end
    Q                              %输出权重向量
else
    disp('对比矩阵A未通过一致性检验，需对对比矩阵A重新构造');
end
