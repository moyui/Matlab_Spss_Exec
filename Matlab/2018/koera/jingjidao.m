%���²����ǵõ���������
cd = 785;%����destnation�Ľڵ���
rd = 481;%���destionation�Ľڵ���
rs = 594;%���supercharge�Ľڵ���
xv=[127.01 126.35 126.39 126.4 126.65 126.91 127.28 127.74 127.84 127.53 127.60 127.01];%�����Χ�㾭��ֵ(ע����β����)
yv=[38.28 37.77 37.59 37.4 37.1 36.92 36.91 37.23 37.55 37.65 37.94 38.28];%�����Χ��γ��ֵ(ͬ��)
%�����Ǹ������У�ũ�壬�е�����ע��ũ�����е�Ҫһһ��Ӧ
city={[126.58 37.33],[126.43 37.26],[127.02 37.15],[127.08 37.26],[126.49 37.39],[127.10 37.14],[126.45 37.30],[126.49 37.19],[126.57 37.23],[127.12 37.38],[127.00 37.17],[127.01 37.44],[126.48 37.22],[127.06 36.59],[126.51 37.28],[126.46 37.45],[126.56 37.21],[127.15 37.25],[126.42 37.36]};
rural={[127.03 37.54],[126.59 37.25],[127.03 38.05]};
middle={[127.02 37.49],[126.58 37.24],[127.03 37.55]};
showCX=[126.58 126.43 127.02 127.08 126.49 127.10 126.45 126.49 126.57 127.12 127.00 127.01 126.48 127.06 126.51 126.46 126.56 127.15 126.42];
showCY=[37.333 37.26 37.15 37.26 37.39 37.14 37.30 37.19 37.23 37.38 37.17 37.44 37.22 36.59 37.28 37.45 37.21 37.25 37.36];
showRX=[127.03 126.59 127.03];
showRY=[37.54 37.25 38.05];
%-----------
es = 12635;%��������ߵ�ľ���
ed = 12784;%�������ұߵ�ľ���
ns = 3691;%�������±ߵ��γ��
nd = 3828;%������������γ��

%-----------��������������QAQ
c1=2;c2=2;%ѧϰ����
w=0.4;%����Ȩֵ
vmaxX=0.1;vmaxY=0.1;%�ٶȳ�ʼ��
max=15;%��������

%���²������Բ���ȥ��
xcd=cell(1,cd);xrd=cell(1,rd);xrs=cell(1,rs);%����Ԫ������
ycd=[];yrd=[];yrs=[];%��ֵ�б�
pbestcd=[];pbestrd=[];pbestrs=[];%�������Ž�
vcdX=[];vrdX=[];vrsX=[];%����ٶ�
vcdY=[];vrdY=[];vrsY=[];
tempdistance=[];
drawcdX=[];drawrdX=[];drawrsX=[];
drawcdY=[];drawrdY=[];drawrsY=[];

%���½��г�ʼ��
%��ʼ������
for i=1:cd %���ɳ���dest������ٶ�
    while(1)
        tempX=0;tempY=0;
        tempX = randi([es,ed],1,1)/100;%�����������
        tempY = randi([ns,nd],1,1)/100;%�������γ��
        in=inpolygon(tempX,tempY,xv,yv);%���ɵ��Ƿ�������
        if (in == 1)%��������
            xcd{1,i} = [tempX tempY];
            break;
        end
    end
    vcdX(i)=rand()/10;
    vcdY(i)=rand()/10;
end

for i=1:rd %����ũ��dest������ٶ�
    while(1)
        tempX=0;tempY=0;
        tempX = randi([es,ed],1,1)/100;%�����������
        tempY = randi([ns,nd],1,1)/100;%�������γ��
        in=inpolygon(tempX,tempY,xv,yv);%���ɵ��Ƿ�������
        if (in == 1)%��������
            xrd{1,i} = [tempX tempY];
            break;
        end
    end
    vrdX(i)=rand()/10;
    vrdY(i)=rand()/10;
end

for i=1:rs %����ũ��super������ٶ�
    while(1)
        tempX=0;tempY=0;
        tempX = randi([es,ed],1,1)/100;%�����������
        tempY = randi([ns,nd],1,1)/100;%�������γ��
        in=inpolygon(tempX,tempY,xv,yv);%���ɵ��Ƿ�������
        if (in == 1)%��������
            xrs{1,i} = [tempX tempY];
            break;
        end
    end
    vrsX(i)=rand()/10;
    vrsY(i)=rand()/10;
end

%������Ӧ�Ⱥ���,�����ֱ�߾���,���Ⱦ��룬γ�Ⱦ���,�����������
[ycd,necity]=fitness(xcd,city);
[yrd,nerural]=fitness(xrd,rural);
[yrs,nemiddle]=fitness(xrs,middle);
%��ʼ����ǰ���弫ֵ�����ҵ�Ⱥ�弫ֵ
for i=1:cd
   pbestcd(i)=ycd(i);
end
citynearPoint={};
for i=1:length(city)
    tempNumber=10^6;
    for j=1:cd
       if((city{1,i}(1,1)==necity{1,j}(1,1))&&(city{1,i}(1,2)==necity{1,j}(1,2)))
           if(pbestcd(j)<tempNumber)
               citynearPoint{1,i}=xcd{1,j}; %�ҵ�����ó�������ĵ�,˳�㱣��ڼ��������
               tempNumber=pbestcd(j);
           end
       end
    end
    if (tempNumber==10^6)%û�з��ָõ�
        citynearPoint{1,i}=0;%���е���ó��ж���Զ
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
               ruralnearPoint{1,i}=xrd{1,j}; %�ҵ������ũ������ĵ�
               tempNumber=pbestrd(j);
           end
       end
    end
    if (tempNumber==10^6)%û�з��ָõ�
        ruralnearPoint{1,i}=0;%���е����ũ�嶼��Զ
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
               middlenearPoint{1,i}=xrs{1,j}; %�ҵ������ũ������ĵ�
               tempNumber=pbestrs(j);
           end
       end
    end
    if (tempNumber==10^6)%û�з��ָõ�
        middlenearPoint{1,i}=0;%���е����ũ�嶼��Զ
    end
end

% ��ʼ�����
% ��������Ⱥ�㷨
for i=1:max
    for j=1:cd
        %����λ�����ٶȣ����÷�������ʽ��ͬʱ���¾�����γ��
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
        %Խ���ж�
         in=inpolygon(xcd{1,j}(1,1),xcd{1,j}(1,2),xv,yv);%���ɵ��Ƿ�������
         if (in == 0) %Խ����
             point=1;value=0;
             for k=1:length(xv)
                 tempdistance(k)=distance(xcd{1,j},[xv(k) yv(k)]);
             end
             [value, point]=min(tempdistance);
             xcd{1,j}=[xv(point) yv(point)];           
         end 
    end
         [ycd,necity]=fitness(xcd,city);
         %���¸�����Ⱥ�弫ֵ
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
                        citynearPoint{1,m}=xcd{1,n}; %�ҵ�����ó�������ĵ�,˳�㱣��ڼ��������
                        tempNumber=pbestcd(n);
                    end
                end
            end
            if (tempNumber==10^6)%û�з��ָõ�
                citynearPoint{1,m}=0;%���е���ó��ж���Զ
            end
         end
end
         for k=1:cd
            drawcdX(k)=xcd{1,k}(1,1);
            drawcdY(k)=xcd{1,k}(1,2);
         end

for i=1:max
    for j=1:rd
        %����λ�����ٶȣ����÷�������ʽ��ͬʱ���¾�����γ��
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
        %Խ���ж�
         in=inpolygon(xrd{1,j}(1,1),xrd{1,j}(1,2),xv,yv);%���ɵ��Ƿ�������
         if (in == 0) %Խ����
             point=1;value=0;
             for k=1:length(xv)
                 tempdistance(k)=distance(xrd{1,j},[xv(k) yv(k)]);
             end
             [value, point]=min(tempdistance);
             xrd{1,j}=[xv(point) yv(point)];           
         end    
    end
         [yrd,nerural]=fitness(xrd,rural);
         %���¸�����Ⱥ�弫ֵ
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
                        ruralnearPoint{1,m}=xrd{1,n}; %�ҵ�����ó�������ĵ�,˳�㱣��ڼ��������
                        tempNumber=pbestrd(n);
                    end
                end
            end
            if (tempNumber==10^6)%û�з��ָõ�
                ruralnearPoint{1,m}=0;%���е���ó��ж���Զ
            end
         end
end
         for k=1:rd
            drawrdX(k)=xrd{1,k}(1,1);
            drawrdY(k)=xrd{1,k}(1,2);
         end

for i=1:max
    for j=1:rs
        %����λ�����ٶȣ����÷�������ʽ��ͬʱ���¾�����γ��
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
        %Խ���ж�
         in=inpolygon(xrs{1,j}(1,1),xrs{1,j}(1,2),xv,yv);%���ɵ��Ƿ�������
         if (in == 0) %Խ����
             point=1;value=0;
             for k=1:length(xv)
                 tempdistance(k)=distance(xrs{1,j},[xv(k) yv(k)]);
             end
             [value, point]=min(tempdistance);
             xrs{1,j}=[xv(point) yv(point)];           
         end    
    end
         [yrs,nemiddle]=fitness(xrs,middle);
         %���¸�����Ⱥ�弫ֵ
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
                        middlenearPoint{1,m}=xrs{1,n}; %�ҵ�����ó�������ĵ�,˳�㱣��ڼ��������
                        tempNumber=pbestrs(n);
                    end
                end
            end
            if (tempNumber==10^6)%û�з��ָõ�
                middlenearPoint{1,m}=0;%���е���ó��ж���Զ
            end
         end
end
         for k=1:rs
            drawrsX(k)=xrs{1,k}(1,1);
            drawrsY(k)=xrs{1,k}(1,2);
         end

plot(xv,yv,'r',drawcdX,drawcdY,'*r',drawrdX,drawrdY,'*g',drawrsX,drawrsY,'*b',showCX,showCY,'o',showRX,showRY,'o');


