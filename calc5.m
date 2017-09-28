clear;clc;
load('Lab1Data.mat');

%initializing


c=299792458 ;
newSatpos=zeros(3,8,7200);
newEL = zeros(8,7200);
newPR= zeros(8,7200);

n=1;
%making New data from only sattelites which are in use
for m = [1,11,13,17,20,23,31,32]
newSatpos(:,n,:)=Satpos(:,m,:);
newEL(n,:) = EL(m,:);
newPR(n,:)=PR(m,:);
n=n+1;
end





iterations=1;
deltaP=zeros(8,1);
P_hat = zeros(8,1);

 ro = zeros(8,1);
 
% saving the dataset;

time = [0:0.5:iterations/2];
R=eye(8);
sol = zeros(4,4);
%initial step
i=1;
k=1;
x=zeros(4,1);
sol(k,:)=x;
for j = 1:8
    ro (j) = sqrt( (newSatpos(1,j,i)-x(1))^2+(newSatpos(2,j,i)-x(2))^2+(newSatpos(3,j,i)-x(3))^2);
end

for j=1:8
P_hat (j) =  ro(j)+x(4)^2;
end
deltaP = P_hat - newPR(:,i)

   G =([(newSatpos(1,1,i)-x(1))/ro(1), (newSatpos(2,1,i)-x(2))/ro(1), (newSatpos(3,1,i)-x(3))/ro(1),1
                                    (newSatpos(1,2,i)-x(1))/ro(2), (newSatpos(2,2,i)-x(2))/ro(2), (newSatpos(3,2,i)-x(3))/ro(2),1
                                    (newSatpos(1,3,i)-x(1))/ro(3), (newSatpos(2,3,i)-x(2))/ro(3), (newSatpos(3,3,i)-x(3))/ro(3),1
                                    (newSatpos(1,4,i)-x(1))/ro(4), (newSatpos(2,4,i)-x(2))/ro(4), (newSatpos(3,4,i)-x(3))/ro(4),1
                                    (newSatpos(1,5,i)-x(1))/ro(5), (newSatpos(2,5,i)-x(2))/ro(5), (newSatpos(3,5,i)-x(3))/ro(5),1
                                    (newSatpos(1,6,i)-x(1))/ro(6), (newSatpos(2,6,i)-x(2))/ro(6), (newSatpos(3,6,i)-x(3))/ro(6),1
                                    (newSatpos(1,7,i)-x(1))/ro(7), (newSatpos(2,7,i)-x(2))/ro(7), (newSatpos(3,7,i)-x(3))/ro(7),1
                                    (newSatpos(1,8,i)-x(1))/ro(8), (newSatpos(2,8,i)-x(2))/ro(8), (newSatpos(3,8,i)-x(3))/ro(8),1]);

 deltaX = inv(transpose(G)*inv(R)*G)*transpose(G)*inv(R)*deltaP;
x(1) = x(1) + deltaX(1);
x(2) = x(2) + deltaX(2);
x(3) = x(3) + deltaX(3);
x(4) = x(4) - deltaX(4);
k=2;
sol(:,k)=x;

for j = 1:8
     ro (j) = sqrt( (newSatpos(1,j,i)-x(1))^2+(newSatpos(2,j,i)-x(2))^2+(newSatpos(3,j,i)-x(3))^2);
end
% 
for j=1:8
 P_hat (j) =  sqrt( (-newSatpos(1,j,i)+x(1))^2+(-newSatpos(2,j,i)+x(2))^2+(-newSatpos(3,j,i)+x(3))^2);
end
 % deltaP(j) = P_hat(j) - newPR(j,i);
% end