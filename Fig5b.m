clear all
clc

n=200;
m=8;
M=20;
R=100;

k=4;

d=3;
D=4;
p=ones(n,1)*100;
eub=zeros(1,D);
eps=zeros(D,M);
res=zeros(D,M);
eps_r=zeros(1,D);


for r=1:R



P=dRRG(n,k)*100/k;
c=sum(P,2)-sum(P,1)'+rand(n,1)*100;
p=sum(P,2);


%%homo
j=1;

S=zeros(n,m);

for i=1:n
    S(i,randperm(m,3))=100/3;
end

eub(j)=eps_ub_1(P,S,c);
eps_r(j)=eps_r(j)+eub(j);
eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finl1(P,S,c,eps(j,i));
end


% het_shares
j=2;

S=zeros(n,m);

for i=1:n
    S(i,randperm(m,3))=1;
    S(i,:)=S(i,:).*rand(1,m);
    S(i,:)=100*S(i,:)/sum(S(i,:));
end

eub(j)=eps_ub_1(P,S,c);
eps_r(j)=eps_r(j)+eub(j);
eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finl1(P,S,c,eps(j,i));
end



%%het_deg
j=3;

S=zeros(n,m);

for i=1:n
    temp=1+randbin(m-1,2/m);
    S(i,randperm(m,temp))=1;
    S(i,:)=S(i,:).*100/temp;
end

eub(j)=eps_ub_1(P,S,c);
eps_r(j)=eps_r(j)+eub(j);
eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finl1(P,S,c,eps(j,i));
end



% het_total
j=4;

S=zeros(n,m);

for i=1:n
    S(i,randperm(m,1+randbin(m-1,2/m)))=1;
    S(i,:)=S(i,:).*rand(1,m);
    S(i,:)=100*S(i,:)/sum(S(i,:));
end

eub(j)=eps_ub_1(P,S,c);
eps_r(j)=eps_r(j)+eub(j);
eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finl1(P,S,c,eps(j,i));
end

display(strcat('Progress: ',num2str(round(100*(r)/R)),'%'))
end

figure
hold on
for j=1:D
plot(linspace(eps_r(j)*(0.02)/R,eps_r(j)*(0.995),M)/R,res(j,:)/R)
end

 
 xlabel('\epsilon') 
ylabel('||p-p||') 
