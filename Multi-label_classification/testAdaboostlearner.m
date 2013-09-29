function[testoutput,ROC,testerror]=testAdaboostlearner(sample,label,hypothesis,alpha)
nhypothesis=size(hypothesis,1);
T=nhypothesis;
nsample=size(sample,1);
% testerrorrate=zeros(1,T);
testoutput=zeros(1,nsample);
h=zeros(1,T);
for t=1:T
    [testoutput]=combineweakclassifer(sample,hypothesis,alpha,t);
    [tempTPR,tempFPR,tempERR]=errorcomputation(testoutput,label');
    ROC{t}=[0 0;tempTPR tempFPR;1 1];
    
%     TPR(t)=tempTPR;
%     FPR(t)=tempFPR;
%     TH(t)=tempTH;
    if(t==1)
        testerror(t)=2*sqrt(tempERR*(1-tempERR));
    else
        testerror(t)=testerror(t-1)*2*sqrt(tempERR*(1-tempERR));
    end
end
