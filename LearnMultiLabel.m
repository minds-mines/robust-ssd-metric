% ********************************************************************** %
% Description:
% This is the main funciton for Learning Multi-Label Instance Specific Distance 
%
% Input:
% X: d by n (d is the feature dimension, n is the number of observations)
% Y: n by K in {0, 1} (K is the number of classes)
% r: regularization parameter
% Udim: reduced feature dimension
%
% Output:
% M: distance matrix for each class
% s: weight for each data in each class
% ********************************************************************** %

function [M, s] = LearnMultiLabel(X, Y, r, Udim)

M = cell(size(Y,2),1);
s = cell(size(Y,2),1);
b = cell(size(Y,2),1);
for k = 1:size(Y,2)
    Xk = X(:,Y(:,k)==1);
    Xnk = X(:,Y(:,k)==0);
    [U, s{k}, obj] = LearnClassToInstanceDistance(Xk, Xnk, r, Udim); 
    M{k} = U*U';
end
