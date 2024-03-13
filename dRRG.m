function A = dRRG(n,d)
% RRG(n,d) creates a random d-regular directed graph with n nodes.
% Important: n*d must be even! Created by Zino.

A=zeros(n);

for i=1:n
    A(i,randperm(n,d))=1;
end
end
