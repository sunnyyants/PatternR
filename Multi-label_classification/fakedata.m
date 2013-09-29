clc;clear;
load rand.mat
x=[];
plot(rand1(:,1),rand1(:,2),'b.');
hold on;
plot(rand2(:,1),rand2(:,2),'r.');
hold on;
plot(rand3(:,1),rand3(:,2),'m.');
hold on;
plot(rand4(:,1),rand4(:,2),'c.');
hold on;
calculateEllipse(0,0,2.5,3.5,90);
calculateEllipse(0,3,2.5,3.5,90);
calculateEllipse(-1,2,3.5,1.5,90);
calculateEllipse(1,2,3.5,1.5,90);
random=[rand1;rand2;rand3;rand4];
title('Multilabel Data Set');

row=size(random,1);
    for i=1:row
        if(ellepsecomputation(random(i,:),0,0,2.5,3.5)<1)
            x(i,1)=1;
        end
        if(ellepsecomputation(random(i,:),0,3,2.5,3.5)<1)
            x(i,2)=2;
        end
        if(ellepsecomputation(random(i,:),-1,2,3.5,1.5)<1)
            x(i,3)=3;
        end
        if(ellepsecomputation(random(i,:),1,2,3.5,1.5)<1)
            x(i,4)=4;
        end
    end
multilabel=[random,x];
size(multilabel);
multilabel=multilabel(randperm(length(multilabel)),:)