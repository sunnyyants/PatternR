function[L]=log_likelihood(k,p,mu,sigma,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of calculating log-likelihood of EM algorithm %
%  Start Date: 2013-3-7   Finished Date: 2013-3-8   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data);        % Measured the size of input data
L=0;                            % Initialized parameter
for i=1:row                     % Computed the log-likelihood
    Sum=0;
    for j=1:k                   % Computed the norm 2 squre for each data
        Sum=Sum+(p(j)*1/((2*pi)^(colomn/2)*...
            sqrt(det(sigma{j})))*exp((-1/2)*(data(i,:)-mu{j})*...
            inv(sigma{j})*(data(i,:)-mu{j})'));
    end
    L=L+log(Sum);               % Got the final log-likelihood
end
end                             % End function
