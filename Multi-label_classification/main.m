function[]=main(originalsample,T,cntfeature)
close all;
if(nargin==3)
    [sample]=dataprocessing(originalsample,cntfeature);
    [row,colomn]=size(sample);
else
    [row,colomn]=size(originalsample);
    sample=originalsample;
    cntfeature=2
end
trainnum=ceil(row*(4/5));
for i=1:trainnum
    trainsample(i,:)=sample(i,:);
end
for j=trainnum+1:row
    testsample(j-trainnum,:)=sample(j-trainnum,:)
end
% [colomn]=size(trainsample,2);
% [tcolomn]=size(testsample,2);
for i=1:cntfeature
    trainfeature(:,i)=trainsample(:,i);
    testfeature(:,i)=testsample(:,i);
end
for i=1:(colomn-cntfeature)
    testlabel(:,i)=testsample(:,i+cntfeature);
    trainlabel(:,i)=trainsample(:,i+cntfeature);
end

[cntlabel]=size(testlabel,2);
testoutput=testfeature;
sumR=zeros(3,2);
sumRR=zeros(3,2);
for labelnum=1:cntlabel
 R=[];
[hypothesis,alpha,costtime,trainerror,ROC,trainout1,trainout2]=adaboostlearner(trainfeature,trainlabel(:,labelnum),T);
[output,tROC,testerror]=testAdaboostlearner(testfeature,testlabel(:,labelnum),hypothesis,alpha);
testoutput=[testoutput,output'];
%     R=tROC{T};
%     RR=ROC{T};
%     sumR=sumR+tROC{T};
%     sumRR=sumRR+ROC{T};
%     figure(1)
%     subplot(2,2,labelnum)
%     plot(R(2,2),R(2,1),'b.','MarkerSize',15)
%     hold on
%     plot(R(:,2),R(:,1),'b-','MarkerSize',12);
%     hold on    
%     plot([0 1],[0 1],'r-');
%     hold on
%      plot(RR(2,2),RR(2,1),'r.','MarkerSize',15)
%     hold on
%     plot(RR(:,2),RR(:,1),'r-','MarkerSize',12);
%     hold on    
%     title('ROC Curve of the trained adaboost classifier');
%     xlabel('False-Positive-Rate');
%     ylabel('True-Positive-Rate');
%     grid on
%     hold on
%     ctime(labelnum,:)=costtime;
% end
%     ncorrect=0;
%     rows=length(testoutput)
%     for rr=1:rows
%         if(testsample(rr,:)==testoutput(rr,:))
%             ncorrect=ncorrect+1;
%         end
%     end
%     Accuracy=ncorrect/rows
    l=length(trainerror);
    ll=length(testerror);
% figure 
    subplot(2,2,labelnum)
    plot([1:l],trainerror,'b.-')
    axis([1 T 0 0.5])
    hold on
    plot([1:ll],testerror,'r.-')
    axis([1 T 0 0.5])
    title('Error rate of the trained adaboost classifier in each iteration')
    xlabel('Iteration');
    ylabel('Error rate');
    hold on
    grid on
    hold on
end
% sumR=sumR/cntlabel;
% testsample1=testoutput(find(output'==0),:);
% testsample2=testoutput(find(output'==1),:);
number_of_correct=length(trainout1)
number_of_wrong=length(trainout2)
% trainout2
% ceil(10+1000*trainout1(a,3))   

% figure 
%     plot(sumR(2,2),sumR(2,1),'b.','MarkerSize',15)
%     hold on
%     plot(sumR(:,2),sumR(:,1),'b-','MarkerSize',12);
%     hold on 
%     title('Average ROC Curve of the trained adaboost classifier');
%     xlabel('Average-False-Positive-Rate');
%     ylabel('Average-True-Positive-Rate');
%     plot([0 1],[0 1],'r-');
%     hold on
%     grid on
% 
% % testoutput=(testlabel==testoutput(:,3:6));
% % figure
% % plotroc(FPR,TPR,'b-');
% 
% 
% figure 
% plot(testsample1(:,1),testsample1(:,2),'m.');
% hold on;
% plot(testsample2(:,1),testsample2(:,2),'c.');
% hold on;

% hypothesis;
% costtime;
 
% figure
% for correct=1:a
%     plot(trainout1(correct,1),trainout1(correct,2),'b.' ,'MarkerSize',ceil(8+400*trainout1(correct,3)));
%     hold on;
% end
%  for wrong=1:b
%      plot(trainout2(wrong,1),trainout2(wrong,2),'r.' ,'MarkerSize',ceil(8+200*trainout1(wrong,3)));
%      hold on
1% title('Scattor plot of trained data set with weights')
% xlabel('Feature1');
% ylabel('Feature2');
% 

% kk=[-3:4]/T;
% for time=1:T
%     if(hypothesis(time,3)==2)
%         plot(kk(time),hypothesis(time,1));
%         hold on
%     end
% end



