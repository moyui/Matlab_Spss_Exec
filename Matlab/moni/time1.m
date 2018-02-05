clc,clear
a = textread('time1.txt','%s');
a=a';
[m,n]=size(a);
for i=1:1:n-1
    data{i}=datestr(datenum(a{i+1},'MM:SS.FFF')-datenum(a{i},'MM:SS.FFF'),'MM:SS.FFF');
end
sum = 0;
for i=1:1:n-1
   sum = sum + datenum(data{i},'MM:SS.FFF')
end
data1 = datestr(sum,'MM:SS.FFF')


    