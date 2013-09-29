% ���������ϻ�����ŵ���ֵ������
% searchBestWeakLearner
% 
% ����ֲ������˹�ֲ�
% ͨ����˹ģ����ȡ�������ľ�ֵ
% ���������ľ�ֵ�м�����������ֵ������
% �������󾫵���������
%
% ����:
% FeatureVector ���������������������������������;������      
% Y             ÿ�������������ı�ʶ;������
% weight        Ȩ������,��ŵ�ǰÿ��������Ȩ��ֵ;������
% ������������������߱���ȵĳ���
% 
% ���磺
%      FeatureVector  Y      weight
% ����1     11        0       0.10 
% ����2     12        0       0.20
% ����3     10        0       0.40 
% ����4     20        1       0.15 
% ����5     30        1       0.15 
% 
% 
% ���:
%  bestError    ��ǰ������������������õ�����С������
%  bestThresh   ��ǰ���������������������ֵ
%  bestBias     ��ǰ�������������������ƫ��
% 
% ����4��,ÿ�ν����仮��Ϊ8��С��
%
% ���ø�ʽΪ
% [bestError,bestThresh,bestBias]=searchBestWeakLearner(FeatureVector,Y,weight)
% 
% 2007-11-12  ����
% 
% findBestWeakLearner ��չ�汾
% 
function [bestError,bestThresh,bestBias]=searchBestWeakLearner(FeatureVector,Y,weight)
error(nargchk(3,3,nargin));         % ����3������,������ֹ����
% ����������������������Ϊ������
iptcheckinput(FeatureVector,{'logical','numeric'},{'column','nonempty','real'},mfilename, 'FeatureVector',1);
iptcheckinput(Y,{'logical','numeric'},{'column','nonempty','integer'},mfilename, 'Y',2);
iptcheckinput(weight,{'numeric'},{'column','nonempty','real'},mfilename, 'weight',3);

cntSamples=length(FeatureVector);    % ��������
if( length(Y)~=cntSamples || length(weight)~=cntSamples ) % ��鳤��
    error('����������������ꡢ������Ȩ�ر���߱���ȵĳ���.');
end
u1=mean(FeatureVector(find(Y==1)));  % ���1��ֵ
u2=mean(FeatureVector(find(Y==0)));  % ���2��ֵ

iteration=4;                         % ��������
sectNum=8;                           % ÿ�ε���,���������򻮷ֵ�Ƭ��

maxFea=max(u1,u2);                   % �����ռ�����ֵ 
minFea=min(u1,u2);                   % �����ռ����Сֵ
step=(maxFea-minFea)/(sectNum-1);    % ÿ�������ĵ�����
bestError=cntSamples;                      % ��ֵ:��õķ�����������

for iter=1:iteration                 % ����iteration��,��Χ����С,Ѱ������ֵ
    tempError=cntSamples;                  % ��ֵ:��iter�ε����ķ�����������      
    for i=1:sectNum                  % ��iter�ε�������������
        thresh=minFea+(i-1)*step;    % ��i����������ֵ
        h=FeatureVector<thresh;      % ������������ֵ������
        errorrate=sum(weight(find(h~=Y)));% ��iter�ε�����i��������Ȩ������
        p=1;
        if(errorrate>0.5)            % �������ʳ���0.5����ƫ�÷���
            errorrate=1-errorrate;
            p=-1;
        end
        if( errorrate<bestError )    % ��iter�ε������ŵĴ����� ��ֵ ƫ��
            bestError=errorrate;     % ��iter�ε�����С�Ĵ�����
            bestThresh=thresh;       % ��iter�ε�����С�����������µ���ֵ
            bestBias=p;              % ��iter�ε�����С�����������µ�ƫ��
        end
    end

    % ��������Χ��С,������������
    span=(maxFea-minFea)/8;          % ������Χ��Ϊԭ�е�1/4                    
    maxFea=bestThresh+span;          % ����������Χ�������ռ�����ֵ     
    minFea=bestThresh-span;          % ����������Χ�������ռ����Сֵ

   step=(maxFea-minFea)/(sectNum-1); % ����������Χ��ÿ�������ĵ�����
end
