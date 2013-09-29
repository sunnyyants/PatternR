function [newdata]=dataprocessing(data,cntfeature)
[row,colomn]=size(data);
newdata=[];
for i=1:cntfeature
    sample(:,i)=data(:,i);
end
for k=1:colomn-cntfeature
    label(:,k)=data(:,k+cntfeature);
end
for j=1:(colomn-cntfeature)
    maximum(j)=max(label(:,j));
    minimun(j)=min(label(:,j));
end
maxi=max(maximum);
mini=min(minimun)+1;
% xxx=colomn-cntfeature
% for r=1:row
%     for j=1:xxx
%         if(label(r,j)~=0)
%             newdata((xxx*(r-1)+j),:)=[sample(r,:),ones(1,1)];
%         else
%             newdata((xxx*(r-1)+j),:)=[sample(r,:),zeros(1,1)];
%         end
%     end
% end
% abc=length(newdata)
% end

newlabel=zeros(row,(maxi-mini+1));
positive=ones(row,1);
for j=1:(colomn-cntfeature)
    templabel=label(:,j);
    for k=mini:1:maxi
        newlabel(:,k)=or(newlabel(:,k),(templabel==(k*ones(row,1))));
    end
end
label=newlabel;
newdata=[sample,newlabel];