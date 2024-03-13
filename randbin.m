function x = randbin(n,p,m)
%randbin(n,p,m) gives m realizations (by default m=1) of a binomial r.v. with parameters n (number of experiments) and p (success probability). Realized by Zino.
if nargin<2
    error('Error, few parameters');
end
if nargin==2
    m=1;
end
if p>1 || p<0 || n<1 || m<1
        error('Error in parameters: p in [0,1], n,m in N');
end
x=zeros(1,m);
for i=1:m
x(i)=sum(randb(p,n,'d'));
end
end

