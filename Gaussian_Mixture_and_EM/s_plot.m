function [classes]=s_plot(data,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This is the sub function of calculating log-likelihood of EM algorithm %
%  Start Date: 2013-3-7   Finished Date: 2013-3-8   Due Date: 2013-3-14   %
%  Programer: Tingshen Yan            Location: Northeastern University   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,colomn]=size(data)
classes=cell(1,k);a=1;           % Define a store space
for i=0:k-1%%%% 
    while data(1,colomn)==i      % Put the data which belong the
        C(a,:)=data(1,:);        % same cluster into one matrix
        a=a+1;
        data(1,:)=[];            % Clean the current row data
        if isempty(data)         % Whether the matrix still exist
            break;               % Break the loop
        end
    end
    C(:,colomn)=[];              % Clean the label
    classes{i+1}=C;              % Put the matrix into store space
    C=[];                        % Reset parameters
    a=1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot Part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:k
    CLA=classes{i};              % Plot different cluster in deferent color
    if i==1;
        plot(CLA(:,1),CLA(:,2),'r.');
        hold on;
    elseif i==2
        plot(CLA(:,1),CLA(:,2),'b*');
        hold on;
    elseif i==3
        plot(CLA(:,1),CLA(:,2),'ko');
        hold on;
    elseif i==4
        plot(CLA(:,1),CLA(:,2),'cp');
        hold on;
    else
        plot(CLA(:,1),CLA(:,2),'g+');
        hold on;
    end
    legend('class1','class2','class3','class4','others');
    hold on;
    title('Data distribution');
end
  