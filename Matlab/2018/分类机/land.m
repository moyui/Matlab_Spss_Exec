clc,clear
a0=load('land.txt');
a=a0';b0=a(:,[1:7]);dd0=a(:,[8:end]);
[b,ps]=mapstd(b0);%已分类数据标准化
dd=mapstd('apply',dd0,ps);%待分类数据标准化
group=[1 2 1 1 2 1 2];%已知样本的标准化
s=svmtrain(b',group);%训练支持向量机
sv_index=s.SupportVectorIndices%返回支持向量的标号
beta=s.Alpha%返回支持向量的权系数
bb=s.Bias%返回分类系数的常数项
mean_and_std_trans=s.ScaleData %第一行返回已知样本点均值向量的相反数，第二行返回的是标准向量差的倒数
check=svmclassify(s,b')%验证已知样本点的错判率
solution=svmclassify(s,dd')%对待判样本点进行分类