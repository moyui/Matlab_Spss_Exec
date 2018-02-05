clc,clear
a = textread('time1.txt','%s');
a=a';
[m,n]=size(a);
sum = 0;
for i=1:1:n-1
   sum = sum + datenum(a{i},'MM:SS.FFF')
end
data1 = datestr(sum,'MM:SS.FFF')