function saperation_plot(data,k,u)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of ploting the data in different clusters.    % 
%  Start Date: 2013-3-4   Finished Date: 2013-3-6   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data);
if colomn>=4                    % If the data is multi-dimensions£¬just 
    data=[data(:,3),data(:,4),data(:,colomn)]; % plot first 2 dimensions.
    [row,colomn]=size(data);    
end
classes=cell(1,k);a=1;          % Define a store space
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Process of Saperating data from different clusters %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:k   
    while data(1,colomn)==i     % Put the data which belong the 
        C(a,:)=data(1,:);       % same cluster into one matrix
        a=a+1;
        data(1,:)=[];           % Clean the current row data
        if isempty(data)        % Whether the matrix still exist
            break;              % Break the loop
        end
    end
    C(:,colomn)=[];             % Clean the label
    classes{i}=C;               % Put the matrix into cell
    C=[];                       % Reset parameters
    a=1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot Part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
for i=1:k
    CLA=classes{i};              % Plot different cluster in deferent color
    if i==1;
        plot(CLA(:,1),CLA(:,2),'rd');
        hold on;
    elseif i==2
        plot(CLA(:,1),CLA(:,2),'b*');
        hold on;
    elseif i==3
        plot(CLA(:,1),CLA(:,2),'ko');
        hold on;
    elseif i==4
        plot(CLA(:,1),CLA(:,2),'m+');
        hold on;
    elseif i==5
        plot(CLA(:,1),CLA(:,2),'gp');
        hold on;
    else
        plot(CLA(:,1),CLA(:,2),'ch');
        hold on
    end
    legend('class1','class2','class3','class4','class5','class6');
    hold on;
end
    plot(u(:,1),u(:,2),'k.','MarkerSize',35,'MarkerFaceColor','k');
    hold on;                        % Plot the final K mean points
    title('The Data Distribution Graph');
    hold on;
end