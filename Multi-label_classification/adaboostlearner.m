function [hypothesis,alpha,costtime,trainerror,ROC,trainout1,trainout2]=adaboostlearner(sample,label,T)
[ns,nf]=size(sample);
% control=0
featureselect=0;
timecountingflag=1;
if(timecountingflag==1)
    tic;
end
sample=ceil(sample*10000)/10000;
positive=find(label==1);
negative=find(label==0);
weight=ones(ns,1);
weight(positive)=1/(2*length(positive));
weight(negative)=1/(2*length(negative));
hypothesis=zeros(T,3);
alpha=zeros(1,T);
Trainerrorrate=zeros(1,T);
costtime=zeros(1,T);
ROC=cell(1,T);
trainoutput=zeros(1,ns);
temph=zeros(1,ns);
t=1;
currentfeaturesize=0;
while(1)
    minierror=ns;
    weight=weight/sum(weight);
    for i=1:nf
        [temperror,tempthreshold,tempbias]=weaklearner(sample(:,i),label,weight);
        if(temperror<minierror)
            minierror=temperror;
            hypothesis(t,:)=[tempthreshold,tempbias,i];
        end
    end
    temph=weaklearnerclassify(sample,hypothesis(t,:));
    errorrate=sum(weight(find(temph~=label)));
    alpha(t)=log10((1-errorrate)/(errorrate+eps));
    if(errorrate>eps)
        weight(find(temph==label))=double(weight(find(temph==label))*exp(-alpha(t)));
        weight(find(temph~=label))=double(weight(find(temph~=label))*exp(alpha(t)));
        trainout1=[sample(find(temph==label),:),weight(find(temph==label))];
        trainout2=[sample(find(temph~=label),:),weight(find(temph~=label))];
    end
    [trainoutput]=combineweakclassifer(sample,hypothesis,alpha,t);
%     plotroc(trainoutput,label')
%     hold on
    out{t}=trainoutput;
    [tempTPR,tempFPR,tempERR]=errorcomputation(trainoutput,label');
    ROC{t}=[0 0;tempTPR tempFPR;1 1];
    
%     TPR(t)=tempTPR;
%     FPR(t)=tempFPR;
%     TH(t)=tempTH;
    if(t==1)
        trainerror(t)=2*sqrt(tempERR*(1-tempERR));
    else
        trainerror(t)=trainerror(t-1)*2*sqrt(tempERR*(1-tempERR));
    end
    if(timecountingflag==1)
        costtime(t)=toc;
    end
    if(t>=T)
        break;
    end
    t=t+1;
end
%     for m=1:T
%         plotroc(out{m},label')
%         hold on
%     end
    if(timecountingflag==1)
        costtime=costtime(find(costtime~=0));
    else
        costtime=0;
    end
end
    
    
    
    