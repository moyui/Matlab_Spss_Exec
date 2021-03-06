%以下参数记得调整！！！
cd = 48;%城市destnation的节点数
rd = 29;%乡村destionation的节点数
rs = 36;%乡村supercharge的节点数
xv=[128.36 127.10 127.61 127.55 127.84 127.73 128.32 128.64 129.36 129.11 128.62 128.36];%区域包围点经度值(注意首尾相连)
yv=[38.58 38.27 37.93 37.63 37.54 37.21 37.21 37.06 37.13 37.56 38.18 38.58];%区域包围点纬度值(同上)
%以下是各个城市，农村，中点坐标注意农村与中点要一一对应
city={[128.07 37.52],[127.76 37.76],[128.81 37.71]};
rural={[128.59 37.09],[127.18 38.08],[127.59 37.29],[128.23 37.22],[128.39 37.22],[128.27 37.11],[128.23 38.23],[127.42 38.06],[127.59 38.06]};
middle={[128.55 37.29],[127.30 38.00],[127.56 37.25],[128.10 37.20],[128.17 37.21],[128.06 37.16],[128.05 38.07],[127.42 37.59],[127.59 37.59]};
showCX=[128.07 127.76 128.81];
showCY=[37.52 37.76 37.71];
showRX=[128.59 127.18 127.59 128.23 128.39 128.27 128.23 127.42 127.59];
showRY=[37.09 38.08 37.29 37.22 37.22 37.11 38.23 38.06 38.06];
%-----------
es = 12710;%区域最左边点的经度
ed = 12936;%区域最右边点的经度
ns = 3706;%区域最下边点的纬度
nd = 3858;%区域最上面点的纬度

%-----------以下是炼丹参数QAQ
c1=2;c2=2;%学习参数
w=0.4;%惯性权值
vmaxX=0.1;vmaxY=0.1;%速度初始化
max=10;%迭代次数

%以下参数可以不用去动
xcd=cell(1,cd);xrd=cell(1,rd);xrs=cell(1,rs);%生成元胞数组
ycd=[];yrd=[];yrs=[];%极值列表
pbestcd=[];pbestrd=[];pbestrs=[];%个体最优解
vcdX=[];vrdX=[];vrsX=[];%随机速度
vcdY=[];vrdY=[];vrsY=[];
tempdistance=[];
drawcdX=[];drawrdX=[];drawrsX=[];
drawcdY=[];drawrdY=[];drawrsY=[];

%以下进行初始化
%初始点生成
for i=1:cd %生成城市dest与随机速度
    while(1)
        tempX=0;tempY=0;
        tempX = randi([es,ed],1,1)/100;%生成随机经度
        tempY = randi([ns,nd],1,1)/100;%生成随机纬度
        in=inpolygon(tempX,tempY,xv,yv);%生成点是否在里面
        if (in == 1)%点在里面
            xcd{1,i} = [tempX tempY];
            break;
        end
    end
    vcdX(i)=rand()/10;
    vcdY(i)=rand()/10;
end

for i=1:rd %生成农村dest与随机速度
    while(1)
        tempX=0;tempY=0;
        tempX = randi([es,ed],1,1)/100;%生成随机经度
        tempY = randi([ns,nd],1,1)/100;%生成随机纬度
        in=inpolygon(tempX,tempY,xv,yv);%生成点是否在里面
        if (in == 1)%点在里面
            xrd{1,i} = [tempX tempY];
            break;
        end
    end
    vrdX(i)=rand()/10;
    vrdY(i)=rand()/10;
end

for i=1:rs %生成农村super与随机速度
    while(1)
        tempX=0;tempY=0;
        tempX = randi([es,ed],1,1)/100;%生成随机经度
        tempY = randi([ns,nd],1,1)/100;%生成随机纬度
        in=inpolygon(tempX,tempY,xv,yv);%生成点是否在里面
        if (in == 1)%点在里面
            xrs{1,i} = [tempX tempY];
            break;
        end
    end
    vrsX(i)=rand()/10;
    vrsY(i)=rand()/10;
end

%调用适应度函数,计算出直线距离,经度距离，纬度距离,最近城市坐标
[ycd,necity]=fitness(xcd,city);
[yrd,nerural]=fitness(xrd,rural);
[yrs,nemiddle]=fitness(xrs,middle);
%初始化当前个体极值，并找到群体极值
for i=1:cd
   pbestcd(i)=ycd(i);
end
citynearPoint={};
for i=1:length(city)
    tempNumber=10^6;
    for j=1:cd
       if((city{1,i}(1,1)==necity{1,j}(1,1))&&(city{1,i}(1,2)==necity{1,j}(1,2)))
           if(pbestcd(j)<tempNumber)
               citynearPoint{1,i}=xcd{1,j}; %找到距离该城市最近的点,顺便保存第几个点最近
               tempNumber=pbestcd(j);
           end
       end
    end
    if (tempNumber==10^6)%没有发现该点
        citynearPoint{1,i}=0;%所有点离该城市都很远
    end
end
         
for i=1:rd
   pbestrd(i)=yrd(i);
end
ruralnearPoint={};
for i=1:length(rural)
    tempNumber=10^6;
    for j=1:rd
       if((rural{1,i}(1,1)==nerural{1,j}(1,1))&&(rural{1,i}(1,2)==nerural{1,j}(1,2)))
           if(pbestrd(j)<tempNumber)
               ruralnearPoint{1,i}=xrd{1,j}; %找到距离该农村最近的点
               tempNumber=pbestrd(j);
           end
       end
    end
    if (tempNumber==10^6)%没有发现该点
        ruralnearPoint{1,i}=0;%所有点离该农村都很远
    end
end

for i=1:rs
   pbestrs(i)=yrs(i);;
end
middlenearPoint={};
for i=1:length(middle)
    tempNumber=10^6;
    for j=1:rs
       if((middle{1,i}(1,1)==nemiddle{1,j}(1,1))&&(middle{1,i}(1,2)==nemiddle{1,j}(1,2)))
           if(pbestrs(j)<tempNumber)
               middlenearPoint{1,i}=xrs{1,j}; %找到距离该农村最近的点
               tempNumber=pbestrs(j);
           end
       end
    end
    if (tempNumber==10^6)%没有发现该点
        middlenearPoint{1,i}=0;%所有点离该农村都很远
    end
end

% 初始化完成
% 进行粒子群算法
for i=1:max
    for j=1:cd
        %更新位置与速度，采用分量的形式，同时更新经度与纬度
        gbestcd=citynearPoint{1,necity{1,j}(1,3)};
        vcdX(j)=w*vcdX(j)+c1*rand()*(necity{1,j}(1,1)-xcd{1,j}(1,1))+c2*rand()*(gbestcd(1)-xcd{1,j}(1,1));
        vcdY(j)=w*vcdY(j)+c1*rand()*(necity{1,j}(1,2)-xcd{1,j}(1,2))+c2*rand()*(gbestcd(2)-xcd{1,j}(1,2));
        if (vcdX(j)>vmaxX) 
            vcdX(j)=vmaxX;
        end
        if (vcdX(j)>vmaxX) 
            vcdX(j)=vmaxX;
        end
            xcd{1,j}=[xcd{1,j}(1,1)+vcdX(j) xcd{1,j}(1,2)+vcdY(j)];
        %越界判断
         in=inpolygon(xcd{1,j}(1,1),xcd{1,j}(1,2),xv,yv);%生成点是否在里面
         if (in == 0) %越界了
             point=1;value=0;
             for k=1:length(xv)
                 tempdistance(k)=distance(xcd{1,j},[xv(k) yv(k)]);
             end
             [value, point]=min(tempdistance);
             xcd{1,j}=[xv(point) yv(point)];           
         end 
    end
         [ycd,necity]=fitness(xcd,city);
         %更新个体与群体极值
         for l=1:cd
             if (ycd(l)>pbestcd(l))
                 pbestcd(l)=ycd(l);
             end
         end
         for m=1:length(city)
            tempNumber=10^6;
            for n=1:cd
                if((city{1,m}(1,1)==necity{1,n}(1,1))&&(city{1,m}(1,2)==necity{1,n}(1,2)))
                    if(pbestcd(n)<tempNumber)
                        citynearPoint{1,m}=xcd{1,n}; %找到距离该城市最近的点,顺便保存第几个点最近
                        tempNumber=pbestcd(n);
                    end
                end
            end
            if (tempNumber==10^6)%没有发现该点
                citynearPoint{1,m}=0;%所有点离该城市都很远
            end
         end
end
         for k=1:cd
            drawcdX(k)=xcd{1,k}(1,1);
            drawcdY(k)=xcd{1,k}(1,2);
         end

for i=1:max
    for j=1:rd
        %更新位置与速度，采用分量的形式，同时更新经度与纬度
        gbestrd=ruralnearPoint{1,nerural{1,j}(1,3)};
        vrdX(j)=w*vrdX(j)+c1*rand()*(nerural{1,j}(1,1)-xrd{1,j}(1,1))+c2*rand()*(gbestrd(1)-xrd{1,j}(1,1));
        vrdY(j)=w*vrdY(j)+c1*rand()*(nerural{1,j}(1,2)-xrd{1,j}(1,2))+c2*rand()*(gbestrd(2)-xrd{1,j}(1,2));
        if (vrdX(j)>vmaxX) 
            vrdX(j)=vmaxX;
        end
        if (vrdX(j)>vmaxX) 
            vrdX(j)=vmaxX;
        end
            xrd{1,j}=[xrd{1,j}(1,1)+vrdX(j) xrd{1,j}(1,2)+vrdY(j)];
        %越界判断
         in=inpolygon(xrd{1,j}(1,1),xrd{1,j}(1,2),xv,yv);%生成点是否在里面
         if (in == 0) %越界了
             point=1;value=0;
             for k=1:length(xv)
                 tempdistance(k)=distance(xrd{1,j},[xv(k) yv(k)]);
             end
             [value, point]=min(tempdistance);
             xrd{1,j}=[xv(point) yv(point)];           
         end    
    end
         [yrd,nerural]=fitness(xrd,rural);
         %更新个体与群体极值
         for l=1:rd
             if (yrd(l)>pbestrd(l))
                 pbestrd(l)=yrd(l);
             end
         end
         for m=1:length(rural)
            tempNumber=10^6;
            for n=1:rd
                if((rural{1,m}(1,1)==nerural{1,n}(1,1))&&(rural{1,m}(1,2)==nerural{1,n}(1,2)))
                    if(pbestrd(n)<tempNumber)
                        ruralnearPoint{1,m}=xrd{1,n}; %找到距离该城市最近的点,顺便保存第几个点最近
                        tempNumber=pbestrd(n);
                    end
                end
            end
            if (tempNumber==10^6)%没有发现该点
                ruralnearPoint{1,m}=0;%所有点离该城市都很远
            end
         end
end
         for k=1:rd
            drawrdX(k)=xrd{1,k}(1,1);
            drawrdY(k)=xrd{1,k}(1,2);
         end

for i=1:max
    for j=1:rs
        %更新位置与速度，采用分量的形式，同时更新经度与纬度
        gbestrs=middlenearPoint{1,nemiddle{1,j}(1,3)};
        vrsX(j)=w*vrsX(j)+c1*rand()*(nemiddle{1,j}(1,1)-xrs{1,j}(1,1))+c2*rand()*(gbestrs(1)-xrs{1,j}(1,1));
        vrsY(j)=w*vrsY(j)+c1*rand()*(nemiddle{1,j}(1,2)-xrs{1,j}(1,2))+c2*rand()*(gbestrs(2)-xrs{1,j}(1,2));
        if (vrsX(j)>vmaxX) 
            vrsX(j)=vmaxX;
        end
        if (vrsX(j)>vmaxX) 
            vrsX(j)=vmaxX;
        end
            xrs{1,j}=[xrs{1,j}(1,1)+vrsX(j) xrs{1,j}(1,2)+vrsY(j)];
        %越界判断
         in=inpolygon(xrs{1,j}(1,1),xrs{1,j}(1,2),xv,yv);%生成点是否在里面
         if (in == 0) %越界了
             point=1;value=0;
             for k=1:length(xv)
                 tempdistance(k)=distance(xrs{1,j},[xv(k) yv(k)]);
             end
             [value, point]=min(tempdistance);
             xrs{1,j}=[xv(point) yv(point)];           
         end    
    end
         [yrs,nemiddle]=fitness(xrs,middle);
         %更新个体与群体极值
         for l=1:rs
             if (yrs(l)>pbestrs(l))
                 pbestrs(l)=yrs(l);
             end
         end
         for m=1:length(middle)
            tempNumber=10^6;
            for n=1:rs
                if((middle{1,m}(1,1)==nemiddle{1,n}(1,1))&&(middle{1,m}(1,2)==nemiddle{1,n}(1,2)))
                    if(pbestrs(n)<tempNumber)
                        middlenearPoint{1,m}=xrs{1,n}; %找到距离该城市最近的点,顺便保存第几个点最近
                        tempNumber=pbestrs(n);
                    end
                end
            end
            if (tempNumber==10^6)%没有发现该点
                middlenearPoint{1,m}=0;%所有点离该城市都很远
            end
         end
end
         for k=1:rs
            drawrsX(k)=xrs{1,k}(1,1);
            drawrsY(k)=xrs{1,k}(1,2);
         end

plot(xv,yv,'r',drawcdX,drawcdY,'*r',drawrdX,drawrdY,'*g',drawrsX,drawrsY,'*b',showCX,showCY,'o',showRX,showRY,'o');



