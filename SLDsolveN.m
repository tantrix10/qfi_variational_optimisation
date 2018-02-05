function [ rhonew, qfin ] = SLDsolveN( H,E, lambda,rho,n )
%SLDSOLVEN Summary of this function goes here
%   Detailed explanation goes here

 rhon=noisen( rho, E,n );
 rhonl=expm(-sqrt(-1)*lambda*H)*rhon*expm(sqrt(-1)*lambda*H);
 
 
 rhodiff=-sqrt(-1)*(((H)*rhonl)-(rhonl*(H)));

 [V,D]=eig(rhonl);
 D(abs(D)<1e-3)=0; 
 L=zeros(2^n);
 
 for i=1:2^n
     for j=1:2^n
         if D(i,i)+D(j,j)==0;
             continue
         end
         rd=((V(:,i)')*rhodiff*V(:,j));
         rd(abs(rd)<1e-3)=0; 
         L=L+(((rd/(D(i,i)+D(j,j))))*(V(:,i)*V(:,j)'));
         
     end
 end
 L=2*L;
 L(abs(L)<1e-3)=0;
 
qfin=((trace(rhonl*(G(H,L)))));
%qfian=trace(rhonl*L*L)

a= maxeig(noisen(G(H,L),E,n)); 


c= (1/sqrt((a')*a))*a;

rhonew=c*c';


%need to put my analytic qfi in here
%qfiformula=4*(1-gamma);
%disp('qfi formula=')
%disp(qfiformula)

%disp('new state=')
%disp( c*c')
%disp('sld=')
%disp(L)
%disp('-----')
%disp('qfi=')
%disp( qfin)

%disp('analytic qfi')
%disp(qfian)
%disp('-----')
end

