clear all
clc

n=200;
m=4;
M=20;
R=100;

d=1:1:10;

D=length(d);
S_base=[1,0,0,0;0 1 0 0; 0 0 1 0; 0 0 0 1; 1 1 0 0; 1 0 1 0; 1 0 0 1; 0 1 1 0; 0 1 0 1; 0 0 1 1; 1 1 1 0; 1 1 0 1; 1 0 1 1; 0 1 1 1; 1 1 1 1];
p=ones(n,1)*100;

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
  


for j=1:D
P=dRRG(n,d(j))*100/d(j);
c=sum(P,2)-sum(P,1)'+rand(n,1)*100;

eub(j)=eps_ub_inf(P,S,c);
eps_r(j)=eps_r(j)+eub(j);
eps(j,:)=linspace(eub(j)*(0.02),eub(j)*(0.995),M);
for i=1:M
    res(j,i)=res(j,i)+finlinf(P,S,c,eps(j,i));
end
display(strcat('Progress: ',num2str(round(100*(j+(r-1)*D)/(D*R))),'%'))
end
end 

figure
hold on
for j=1:D
plot(linspace(eps_r(j)*(0.02)/R,eps_r(j)*(0.995),M)/R,res(j,:)/R)
end

 Legend=cell(D,1);
 for iter=1:D
   Legend{iter}=strcat('d=', num2str(iter));
 end
 legend(Legend)
 xlabel('\epsilon') 
ylabel('||p-p||') 
