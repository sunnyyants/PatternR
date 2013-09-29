function[p,mu,sigma]=Mstep(k,z,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of running M-step in the EM algorithm         % 
%  Start Date: 2013-3-7   Finished Date: 2013-3-8   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[drow,dcolomn]=size(data);      % Measure the size of data
[row,colomn]=size(z);           % Measure the size of E[Zij] matrix
mu=cell(k,1);                   % Define some store space
sigma=cell(k,1);                
p=zeros(1,k);u=zeros(k,dcolomn);sig=0*eye(dcolomn); % Initialization
for j=1:k 
    for i=1:row                 % Calculated the new probability ¦Ðij
        p(j)=p(j)+z(i,j);
    end
    p(j)=p(j)/row;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    for i=1:row                 % Calculated the new mean mu
        u(j,:)=u(j,:)+z(i,j)*data(i,:);
    end
    u(j,:)=u(j,:)/(row*p(j));   
    mu{j}=u(j,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    for i=1:row                 % Calculated the new covariance matrix
        sig=sig+z(i,j)*(data(i,:)-mu{j})'*(data(i,:)-mu{j});
    end
    sig=sig/(row*p(j));         
    sigma{j}=sig;
    sig=0*eye(dcolomn);         % Reset the parameter
end
end                             % End function