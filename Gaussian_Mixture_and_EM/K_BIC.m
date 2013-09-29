function[BICMAX,list]=K_BIC(r,K,mdata)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the main function of Calculating the BIC Score in algorithm 3  % 
%  Start Date: 2013-3-8   Finished Date: 2013-3-8   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(mdata);
colomn=colomn-1;
list=cell(K,3);
list{1,1}='K';list{1,2}='Log-likelihood';list{1,3}='BIC';
for i=1:K                           % For clustering i clusters from 1 to k
    list{i+1,2}=Gauss_Mix_Clustering(r,i,mdata); 
    % Runing algorithm 2 for different k to get different log-likelihood
    list{i+1,1}=i;                  % Print out the current k clusters
    list{i+1,3}=list{i+1,2}-(i-1+i*colomn+colomn*(colomn+1)/2*i)/2*log(row);
    % Computing the BIC Score for each different k clusters
    BIC(i,1)=list{i+1,1};           % Rebuilt a matrix in order to plot
    BIC(i,2)=list{i+1,3};           % the BIC curve
end
    [BICMAX,I]=max(BIC);
    figure
    plot(BIC(:,1),BIC(:,2),'b-');
    hold on;
    plot(BIC(:,1),BIC(:,2),'b.','MarkerSize',8);
    hold on;
    grid on;
    title('The BIC criterion curve');
end