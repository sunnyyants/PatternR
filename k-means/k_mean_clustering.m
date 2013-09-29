function[]=k_mean_clustering(r,K,mdata)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the main function of running the K-Mean-Clustering Algorithm.  % 
%  Start Date: 2013-3-4   Finished Date: 2013-3-6   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[observations,variables]=size(mdata);   % Measure the size of data
for i=1:variables-1;                    % Clean the labels of original data    
    data(:,i)=mdata(:,i);               
end
figure;                                 % Plot the Original data set                      
plot(data(:,1),data(:,2),'b*');
hold on;
for i=1:r                               % Define a r times loop that the 
                                        % total algorithm rums
    [randmu,dimension]=mean_initialization(data);
% Recall Mean_initialization function to measure the range of data 
    times=0;n=1;mx=1;my=1;              % Initialized some parameters
        while mx<=K                     
%%%%%%%%%%%%% Initialized-the-first-K-points-randomly-Process %%%%%%%%%%%%%
            while n<=dimension          
            u(mx,my)=(randmu(2*n-1)-randmu(2*n))*rand(1,1)+randmu(2*n);
            n=n+1;
            my=my+1;
            end
            mx=mx+1;
            n=1;
            my=1;
        end                             % Initialization processing end
        mx=1;                           % Reset some parameters
        a=1;
%%%%%%%%% Enter the main loop to find out the final K mean points %%%%%%%%%
        while 1                         
            times=times+1;              % Total times that get u-convergence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Find-the-Shortest-Distance-Process %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for dx=1:observations       % For every data row
                while a<=K
                    X=[data(dx,:);u(a,:)];
                    d(a)=pdist(X);      % Computed the Euclidean distance 
                    a=a+1;          
                end
                [minimum,classnum]=min(d); % Find out the shortest distance
                sorted_data(dx,:)=[data(dx,:),classnum];% Labeled data
                d=[];                   % Clean the parameter matrix
                a=1;                    % Reset Parameter
            end                         % End process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%%%%%%%%%%%%%%%%%%%%%% Updated-K-mean-points-Process %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            sorted_data=sortrows(sorted_data,variables);
            % Sorted new data matrix by new labels
            exu=u;t_exu=transform(u);
            u=data_update(sorted_data,K); % Recall function
            t_u=transform(u);
%%%%%%%%%%%%%%%%%%%%%%%% Sum-Squared-Error-Process %%%%%%%%%%%%%%%%%%%%%%%%
%             e=sum_squared_error(times,K,u,sorted_data);
%             err(times,:)=e;
%%%%%%%%%%%%%%%%%%%%%%%%%%% Reach Convergence? %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if(pdist2(t_exu,t_u)<=0.0001) 
%%%%%%%%%%%%%%%%%%%%%% Plot with different clusters %%%%%%%%%%%%%%%%%%%%%%%    
                saperation_plot(sorted_data,K,u); 
                break;                  % Break the main loop   
            end
        end     % If we haven't reach the convergence, we do the it again
        times=0;                        % Reset parameter   
%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot SSE Curve Part %%%%%%%%%%%%%%%%%%%%%%%%%%% 
% figure
% plot(err(:,1),err(:,2),'b-');
% hold on;
% plot(err(:,1),err(:,2),'b.','MarkerSize',10);
% hold on;
% title('The Sum Squared Error Curve');
% hold on;
% grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end                                     % End a full time algorithm
end                                     % End function
            
                  
        
           