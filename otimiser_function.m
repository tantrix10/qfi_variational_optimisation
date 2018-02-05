function [ QFI ] = otimiser_function( gamma, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



profile on
m=100000;
rho=(1/2^n)*ones(2^n);
rho(1,2^n)=0.1;
rho(2^n,1)=0.1;
hd=[1 0; 0 -1];
lambda=30;
H=zeros(2^n);
h=cell(1,n);

for j =1:n;
    h{j}=eye(2);
end

for i=1:n;
    y=h;
    y{i}=hd;
    H=H+single_particle_hamiltonian(y,n);
end

e=npermutek(['b','c'],n);


c=[1 0; 0 sqrt(1-gamma)];%=e1
b=[0 0; 0 sqrt(gamma)];%=e0


ek=cell((2^n),n);

for i=1:2^n
    for j=1:n;
        ek{i,j}=eval(e(i,j));
    end
end

E=cell(1,2^n);

for i=1:(2^n);
    E{i}=kronr(ek(i,:),n);
end

%so now E, is the set of all our kraus operators
%NOTE: beacuse all kraus operators are real and diagonal, I have not
%bothered with any transposes
rhosolutions=cell(1,m+1);
rhosolutions{1,1}=rho;
qfis=rand(1,5);
for i=1:m
    if qfis(1,mod(i,5)+1)==qfis(1,mod(i-1,5)+1); %|| qfis(1,5)==qfis(1,3) || qfis(1,5)==qfis(1,2);
        disp('terminated due to convergence')
        break
    end
   
    [d,qfin]=SLDsolveN(H,E,lambda,rhosolutions{i},n);
    rhosolutions{1,i+1}=d;
    qfis(1,mod(i,5)+1)=real(qfin);
   
    

end


QFI=qfis(1,mod(i,5)+1);
disp(QFI)



end


