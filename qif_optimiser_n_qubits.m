clear
profile on
prompt='How many qubits? n=';
n=input(prompt);
prompt2='Max number of itterations? m= ';
m=input(prompt2);

%define some input state that has off diagonal terms

%NOTE: this choice of initial input state remains stuck in the nxn
%subspace. There is something to be explored here, do rank deficient SLD's
%represent local maxima and minima?
%rho=(1/n)*eye(2^n);
%rho=zeros(2^n);
%rho(1,n)=0.5;
%rho(n,1)=0.5;
%rho(1,1)=1;
%rho(n,n)=0.5;
%if it takes GHZ as an input, it remains stable and coverges quickly 
%rho(1,1)=0.5;
%rho(1,2^n)=0.5;
%rho(2^n,1)=0.5;
%rho(2^n,2^n)=0.5;


rho=(1/2^n)*ones(2^n);
%rho(1,2^n)=0.1;
%rho(2^n,1)=0.1;

%rho=eye(2^n);
%rho=(1/trace(rho))*rho;


%single particle hamiltonianb
hd=[1 0; 0 -1];
%define some paramenter to be estimated, this could be done with user
%input, but for now I will hard code it to save testing time
lambda=30;
%zero maxtrix with size of global system
H=zeros(2^n);
%a cell of matricies all of which are defined to be identity
%we then in turn make each one the single particle hamiltonian and take
%tesnor products

h=cell(1,n);

for j =1:n;
    h{j}=eye(2);
end
%now we need to generate the  hamiltonian
for i=1:n;
    y=h;
    y{i}=hd;
    H=H+single_particle_hamiltonian(y,n);
end
%so now H is our Hamiltonian

%okay, so now I need to define a cell with rho as the first entry and zero
%as the rest. then each step will append/change the ith cell entry. Also
%the length shoudl be pre-set to the number of itterations I wish to run.
%Perhaps also look at defining a second termination condition.

%I also need some function to define the kraus operators
gamma=0.4;
%should put a statment here if gamma=0 to by pass this step
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
    fprintf('itteration %d. QFI: %d \n',i,qfin)
end
figure 
stem3(abs(rhosolutions{1,i}))