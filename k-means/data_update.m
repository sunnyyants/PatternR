function [u]=data_update(data,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of computing the new K mean points.           % 
%  Start Date: 2013-3-4   Finished Date: 2013-3-6   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data);
sum_data=zeros(1,colomn);       % Defind a vector to compute the summation
num=0;
for i=1:k
    for j=1:row
        if length(data)~=0      
            if data(j,colomn)==i    % Added the data for each cluster
            sum_data(1,:)=sum_data(1,:)+data(j,:);
            num=num+1;              % Compute the data # of each cluster 
            end                     
        end 
    end
    sum_data(:,colomn)=[];
    umean=sum_data/num;             % Generate a new K mean points
    sum_data=zeros(1,colomn);       % Reset the zero-vector
    for x=1:num                     % Clean the same cluster data
        data(1,:)=[];               % in order to computer next cluster
    end                             % much more easily
    num=0;
    [row,colomn]=size(data);
     u(i,:)=umean;                  % Updated the K mean points
end                                 % End function
    
            
