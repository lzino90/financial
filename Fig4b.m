clear all
clc

n=200;
m=4;
M=20;
R=100;

k=4;


D=3;
S_base=[1,0,0,0;0 1 0 0; 0 0 1 0; 0 0 0 1; 1 1 0 0; 1 0 1 0; 1 0 0 1; 0 1 1 0; 0 1 0 1; 0 0 1 1; 1 1 1 0; 1 1 0 1; 1 0 1 1; 0 1 1 1; 1 1 1 1];
eub=zeros(1,D);
eps=zeros(D,M);
res=zeros(D,M);
eps_r=zeros(1,D);


for r=1:R


S=zeros(n,m);

for i=1:n
    S(i,:)=100*S_base(randi(15),:).*rand(1,m);
    S(i,:)=S(i,:)/sum(S(i,:));
end


%%RRG
j=1;

P=dRRG(n,k)*100/k;
c=sum(P,2)-sum(P,1)'+rand(n,1)*100;
p=sum(P,2);

eub(j)=eps_ub_inf(P,S,c);
eps_r(j)=eps_r(j)+eub(j);
eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finlinf(P,S,c,eps(j,i));
end

%low_het
j=2;

d=1+poissrnd(k-1,n,1);

P=dRG(n,d)*25;

c=sum(P,2)-sum(P,1)'+rand(n,1)*100;
p=sum(P,2);

eub(j)=eps_ub_inf(P,S,c);
eps_r(j)=eps_r(j)+eub(j);

eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finlinf(P,S,c,eps(j,i));
end


%%high_het
j=3;

d=zipf_rand(199,1.94,200);

P=dRG(n,d)*25;

c=sum(P,2)-sum(P,1)'+rand(n,1)*100;
p=sum(P,2);

eub(j)=eps_ub_inf(P,S,c);
eps_r(j)=eps_r(j)+eub(j);

eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finlinf(P,S,c,eps(j,i));
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
