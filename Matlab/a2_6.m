rand('state',sum(clock));
p0=0;
tic
for i=1:10^6
    x=randi([0,99],1,5);
    [f,g]=mengte(x);
    if all(g<=0)
        if p0<f
            x0=x;p0=f;
        end
    end
end
x0,p0
toc