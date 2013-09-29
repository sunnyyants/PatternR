function [solution]=ellepsecomputation(point,x,y,b,a)
X=point(1);
Y=point(2);
solution=(((X-x)^2)/(a^2))+(((Y-y)^2)/(b^2));
end