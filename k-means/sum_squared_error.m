function[e]=sum_squared_error(times,k,u,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of computing the new K mean points.           % 
%  Start Date: 2013-3-4   Finished Date: 2013-3-6   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data);
classes=cell(1,k);a=1;error=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Process of Saperating data from different clusters %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:k 
    while data(1,colomn)==i         % Put the data which belong the 
                                    % same cluster into one matrix
        C(a,:)=data(1,:);           
        a=a+1;
        data(1,:)=[];               % Clean the current row data
        if isempty(data)            % Whether the matrix still exist
            break;                  % Break the loop
        end
    end
    C(:,colomn)=[];                 % Clean the label
    classes{i}=C;                   % Put the matrix into cell
    C=[];                           % Reset parameters
    a=1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Sum Squared Error Computation %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:k
    X=classes{i};sum=0;             
    while 1
        sum=sum+(norm((X(1,:)-u(i,:))))^2;  % Computed ||yi-mi||^2;
        X(1,:)=[];                  
        if isempty(X)
            break;                  % Break the loop
        end
    end
    error=error+sum;                % Computed the summation of error 
end
e=[times,error/row];                % Get the final SSES
        