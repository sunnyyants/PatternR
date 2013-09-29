function [output]=weaklearnerclassify (sample, hypothesis)
threshold=hypothesis(1);
bias=hypothesis(2);
feature=hypothesis(3);
output=((bias.*sample(:,feature))<(bias.*threshold));
end


