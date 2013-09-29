function[Z]=Estep(k,p,mu,sigma,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of running E-step in the EM algorithm         %
%  Start Date: 2013-3-7   Finished Date: 2013-3-8   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data);      % Measured the size of the input data
denominator=0;                % Initialized the denominator of E[Zij]
for i=1:row                          
    for j=1:k                 % Computed the denominator of E[Zij]
        denominator=denominator+p(j)*1/((2*pi)^(colomn/2)*...
            sqrt(det(sigma{j})))*exp((-1/2)*(data(i,:)-mu{j})*...
            inv(sigma{j})*(data(i,:)-mu{j})');
    end
    for j=1:k                 % Computed the numerator of E[Zij]
        numerator=p(j)*1/((2*pi)^(colomn/2)*sqrt(det(sigma{j})))*...
            exp((-1/2)*(data(i,:)-mu{j})*inv(sigma{j})*(data(i,:)-mu{j})');
        Z(i,j)=numerator/denominator;
    end
    denominator=0;            % Clean the denominator for next computation
end
end