function [output]=combineweakclassifer(sample,hypothesis,alpha,time)
samplesize=size(sample,1);
boostthresh=0.5;
output=zeros(1,samplesize);
hypothesis=hypothesis(1:time,:);
alpha=alpha(1:time);
for i=1:samplesize
    h=zeros(1,time);
    for t=1:time
        threshold=hypothesis(t,1);
        p=hypothesis(t,2);
        j=hypothesis(t,3);
        if(p*sample(i,j)<(p*threshold))
            h(t)=1;
        end
    end
    temph=sum(alpha.*h);
    if(temph>=(boostthresh*sum(alpha)));
        output(i)=1;
    end
end