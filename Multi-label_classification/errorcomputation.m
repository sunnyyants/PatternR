function [TPR,FPR,ERR]=errorcomputation(predictresult,correctresult)
TP=and(predictresult,correctresult);
ER=correctresult-predictresult;
ERR=double(length(find(ER~=0))/length(correctresult));
TPR=length(find(TP==1))/length(find(correctresult==1));
FPR=length(find(ER==-1))/length(find(correctresult==0));
% [TPR,FPR,TH]=roc(correctresult,predictresult);
% plotroc(correctresult,predictresult)
% hold on
end
