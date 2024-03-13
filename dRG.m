function A = dRG(n,d)
% RRG(n,d) creates a random  directed graph with n nodes and given degree
% sequence d. Created by Zino.

A=zeros(n);

for i=1:n
    A(i,randperm(n,d(i)))=1;
end
end
