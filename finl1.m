function [eta_opt,delta_opt,i_star,lambda_opt,beta_opt] = finl1(P,S,c,epsilon)

n=size(P,1);
m=size(S,2);
p=sum(P,2);
A=diag(sum(P,2).^-1)*P;
A1=[A-eye(n), -eye(n)];
eta_opt=-Inf;
beta_opt=zeros(1,n);
lambda_opt=zeros(1,n);

for i=1:m
    f=[-epsilon*S(:,i)'+c', +p'];
        options = optimoptions('linprog','Display','none');
x = linprog(f,A1,-ones(n,1),[],[],zeros(2*n,1),[],options);
    eta=sum(p)-f*x;
    if eta>eta_opt
        i_star=i;
        eta_opt=eta;
        lambda_opt=x(1:n);
        beta_opt=x(n+1:2*n);
    end
end

delta_opt=zeros(m,1);
delta_opt(i_star)=-epsilon*sign(S(:,i_star)'*lambda_opt);
end