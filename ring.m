function A = ring(n,m)
%A = ring(n,m) generates a ring with network size n and m number of
%connections (per side)

A=zeros(n); 
for i=1:m
    A=A+diag(ones(n-i,1),i)+diag(ones(n-i,1),-i)+diag(ones(i,1),n-i)+diag(ones(i,1),-n+i); %we create the diagonal bands
end
end