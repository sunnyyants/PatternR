function[ui,dim]=mean_initialization(data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of finding out the ranges of the data.        % 
%  Start Date: 2013-3-4   Finished Date: 2013-3-6   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data);
for i=1:colomn
    u(2*i-1)=round(max(data(:,i))); % Put the maximum number in each odd item
    u(2*i)=round(min(data(:,i)));   % Put the maximum number in each even item
end
ui=u;                               % Output the mu vector
dim=colomn;                         % Output the dimension of data
end