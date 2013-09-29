function [ferror threshold bias]=weaklearner(feature,label,weight)
simple_size=length(feature);
if( length(label)~=simple_size || length(weight)~=simple_size)
    error('The length of label and weight should be the same as feature');
end
for i=0:max(label)
    mu(i+1)=mean(feature(find(label==i)));
end
iteration=4;
section=8;
minifeature=min(mu);
maxifeature=max(mu);
step=(maxifeature-minifeature)/(section-1);
ferror=simple_size;
for j=1:iteration
%     temp_error=simple_size;
    for k=1:section
        tempthreshold=minifeature+(k-1)*step;
        h=feature<tempthreshold;
        errorrate=sum(weight(find(h~=label)));
        p=1;
        if(errorrate>0.5)
            errorrate=1-errorrate;
            p=-1;
        end
        if(errorrate<ferror)
            ferror=errorrate;
            threshold=tempthreshold;
            bias=p;
        end
    end
    range=(maxifeature-minifeature)/8;
    maxifeature=threshold+range;
    minifeature=threshold-range;
    step=(maxifeature-minifeature)/(section-1);
end
        