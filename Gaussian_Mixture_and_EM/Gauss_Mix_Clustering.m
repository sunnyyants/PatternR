function[CC]=Gauss_Mix_Clustering(r,k,mdata)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the main function of running the EM Algorithm in mixture data  % 
%  Start Date: 2013-3-7   Finished Date: 2013-3-8   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(mdata);           % Measured the size of the input data 
mu=cell(k,1);                       % Defined some store space
sigma=cell(k,1);                
for i=1:colomn-1;                   % Cleaned the original labels
    data(:,i)=mdata(:,i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Loop of R times that the total algorithm runs %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:r                           
    times=0;                        % Initialized parameter
    figure
    for j=1:k                       % Define k clusters ( Initialzed part)
        mu{j}=data(round((row-1)*rand(1,1)+1),:); 
        % Picked up k points from original data randomly
        sigma{j}=eye(colomn-1);     
        % Generated D dimensions indentity matrix
        p(j)=1/k;                   % Initialized the probability
        tiny=0.00001*fliplr(eye(colomn-1));
        plot_gauss(data,mu{j},(sigma{j}+tiny),3,4);
        hold on;
        title('The Initial Parameter Values Plot');    
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Main loop part which contain E-step & M-step %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while 1
        matrixz=Estep(k,p,mu,sigma,data);  
        % Recall the Estep function to generate the matrix E[Zij]
        [np,nmu,nsigma]=Mstep(k,matrixz,data);
        % Recall the Mstep function to compute the new parameters
        A=log_likelihood(k,p,mu,sigma,data);    
        % Recall the sub_function to calculate the old log-likelihood
        B=log_likelihood(k,np,nmu,nsigma,data);
        % Recall the sub function to calculate the new log-likelihood
        times=times+1; % Add the times that the E,M-steps run
            if (abs(B-A)<0.001)||(times==80)
            % Judgment condition (Convergence)
                CC=B;                   % Output the final log-likelihood
                break;
            else                        % If we haven't got convergence
            p=np;mu=nmu;sigma=nsigma;   % Update the parameters
            LOG(times,:)=[times,A];     % Generate a table of log-likehood
            end                         % End judgment
    end
    figure                              % Plot the different Gaussian 
    for j=1:k                           % regions with different clusters
        plot_gauss(data,nmu{j},nsigma{j},3,4);
        hold on;
    end                                 % End plot
   %%%%%%%%%%%%%%%%%% Plot the original data distribution %%%%%%%%%%%%%%%%%
    figure 
    pdata=sortrows(mdata,colomn); % Plot the original 
    s_plot(pdata,k);              % data distributions
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    figure                              % Plot the Log-likelihood curve
    axis([0 60 -1000 -700]);
    plot(LOG(:,1),LOG(:,2),'b-')
    hold on;
    plot(LOG(:,1),LOG(:,2),'b.-','MarkerSize',6)
    hold on;
    grid on;
    title('Curve of Log-Likelihood');
end                                     % End a full algorithm
end                                     % End function

