clear;clc;
load('Lab1Data.mat');

%initializing


c=299792458 ;
newSatpos=zeros(3,8,7200);
newEL = zeros(8,7200);
newPR= zeros(8,7200);

j=1;
%making New data from only sattelites which are in use
for k = [1,11,13,17,20,23,31,32]
newSatpos(:,j,:)=Satpos(:,k,:);
newEL(j,:) = EL(k,:);
newPR(j,:)=PR(k,:);
j=j+1;
end





iterations=1;
 deltaP=zeros(8,1);
 P_hat = zeros(8,1);

 ro = zeros(8,1);
 
% saving the dataset;

time = [0:0.5:iterations/2];
R=eye(8);

%initial step
i=1;
k=1;
x = zeros(4,iterations*10);
%sol(:,i)=x(:,i);
ro(:) = 3185000;
  for j =1:8
P_hat(j) =sqrt( (-newSatpos(1,j,i)+x(1,k))^2 +(-newSatpos(2,j,i)+x(2,k))^2 + (-newSatpos(3,j,i)+x(3,k))^2)+ c*x(4,k);
deltaP(j) =P_hat(j) - newPR(j,i);       
  end
  G =([(newSatpos(1,1,i)-x(1,k))/ro(1), (newSatpos(2,1,i)-x(2,k))/ro(1), (newSatpos(3,1,i)-x(3,k))/ro(1),1
                                    (newSatpos(1,2,i)-x(1,k))/ro(2), (newSatpos(2,2,i)-x(2,k))/ro(2), (newSatpos(3,2,i)-x(3,k))/ro(2),1
                                    (newSatpos(1,3,i)-x(1,k))/ro(3), (newSatpos(2,3,i)-x(2,k))/ro(3), (newSatpos(3,3,i)-x(3,k))/ro(3),1
                                    (newSatpos(1,4,i)-x(1,k))/ro(4), (newSatpos(2,4,i)-x(2,k))/ro(4), (newSatpos(3,4,i)-x(3,k))/ro(4),1
                                    (newSatpos(1,5,i)-x(1,k))/ro(5), (newSatpos(2,5,i)-x(2,k))/ro(5), (newSatpos(3,5,i)-x(3,k))/ro(5),1
                                    (newSatpos(1,6,i)-x(1,k))/ro(6), (newSatpos(2,6,i)-x(2,k))/ro(6), (newSatpos(3,6,i)-x(3,k))/ro(6),1
                                    (newSatpos(1,7,i)-x(1,k))/ro(7), (newSatpos(2,7,i)-x(2,k))/ro(7), (newSatpos(3,7,i)-x(3,k))/ro(7),1
                                    (newSatpos(1,8,i)-x(1,k))/ro(8), (newSatpos(2,8,i)-x(2,k))/ro(8), (newSatpos(3,8,i)-x(3,k))/ro(8),1]);

    deltaX = (G'*R*G)\G'*R*deltaP;
x(1,k+1) = x(1,k)+deltaX(1);
x(2,k+1) = x(2,k) + deltaX(2);
x(3,k+1) = x(3,k) + deltaX(3);
x(4,k+1) = x(4,k) - deltaX(4);

k=2;
ro((k)) = sqrt( (x(1,k)-x(1,k-1))^2 +(x(2,k)-x(2,k-1))^2 + (x(3,k)-x(3,k-1))^2) ;
  for j =1:8
P_hat(j) =sqrt( (-newSatpos(1,j,i)+x(1,k))^2 +(-newSatpos(2,j,i)+x(2,k))^2 + (-newSatpos(3,j,i)+x(3,k))^2)+ c*x(4,k);
deltaP(j) =P_hat(j) - newPR(j,i);       
  end
  G =([(newSatpos(1,1,i)-x(1,k))/ro(1), (newSatpos(2,1,i)-x(2,k))/ro(1), (newSatpos(3,1,i)-x(3,k))/ro(1),1
                                    (newSatpos(1,2,i)-x(1,k))/ro(2), (newSatpos(2,2,i)-x(2,k))/ro(2), (newSatpos(3,2,i)-x(3,k))/ro(2),1
                                    (newSatpos(1,3,i)-x(1,k))/ro(3), (newSatpos(2,3,i)-x(2,k))/ro(3), (newSatpos(3,3,i)-x(3,k))/ro(3),1
                                    (newSatpos(1,4,i)-x(1,k))/ro(4), (newSatpos(2,4,i)-x(2,k))/ro(4), (newSatpos(3,4,i)-x(3,k))/ro(4),1
                                    (newSatpos(1,5,i)-x(1,k))/ro(5), (newSatpos(2,5,i)-x(2,k))/ro(5), (newSatpos(3,5,i)-x(3,k))/ro(5),1
                                    (newSatpos(1,6,i)-x(1,k))/ro(6), (newSatpos(2,6,i)-x(2,k))/ro(6), (newSatpos(3,6,i)-x(3,k))/ro(6),1
                                    (newSatpos(1,7,i)-x(1,k))/ro(7), (newSatpos(2,7,i)-x(2,k))/ro(7), (newSatpos(3,7,i)-x(3,k))/ro(7),1
                                    (newSatpos(1,8,i)-x(1,k))/ro(8), (newSatpos(2,8,i)-x(2,k))/ro(8), (newSatpos(3,8,i)-x(3,k))/ro(8),1]);

    deltaX = (G'*R*G)\G'*R*deltaP;
x(1,k+1) = x(1,k)+deltaX(1);
x(2,k+1) = x(2,k) + deltaX(2);
x(3,k+1) = x(3,k) + deltaX(3);
x(4,k+1) = x(4,k) - deltaX(4);




% for j =1:8
%       ro(j) = sqrt( (x(1,k)-x(1,k-1))^2 +(x(2,k)-x(2,k-1))^2 + (x(3,k)-x(3,k-1))^2) ;
% P_hat(j) =sqrt( (-newSatpos(1,j,i)+x(1,k))^2 +(-newSatpos(2,j,i)+x(2,k))^2 + (-newSatpos(3,j,i)+x(3,k))^2)+ c*x(4,k);
% deltaP(j) =P_hat(j) - newPR(j,i);       
% end

% for k=2:10
%   for j =1:8
%       ro(j) = sqrt( (x(1,k)-x(1,k-1))^2 +(x(2,k)-x(2,k-1))^2 + (x(3,k)-x(3,k-1))^2) ;
% P_hat(j) =sqrt( (-newSatpos(1,j,i)+x(1,k))^2 +(-newSatpos(2,j,i)+x(2,k))^2 + (-newSatpos(3,j,i)+x(3,k))^2)+ c*x(4,k);
% deltaP(j) =P_hat(j) - newPR(j,i);       
%   end
% G =([(newSatpos(1,1,i)-x(1,k))/ro(1), (newSatpos(2,1,i)-x(2,k))/ro(1), (newSatpos(3,1,i)-x(3,k))/ro(1),1
%                                     (newSatpos(1,2,i)-x(1,k))/ro(2), (newSatpos(2,2,i)-x(2,k))/ro(2), (newSatpos(3,2,i)-x(3,k))/ro(2),1
%                                     (newSatpos(1,3,i)-x(1,k))/ro(3), (newSatpos(2,3,i)-x(2,k))/ro(3), (newSatpos(3,3,i)-x(3,k))/ro(3),1
%                                     (newSatpos(1,4,i)-x(1,k))/ro(4), (newSatpos(2,4,i)-x(2,k))/ro(4), (newSatpos(3,4,i)-x(3,k))/ro(4),1
%                                     (newSatpos(1,5,i)-x(1,k))/ro(5), (newSatpos(2,5,i)-x(2,k))/ro(5), (newSatpos(3,5,i)-x(3,k))/ro(5),1
%                                     (newSatpos(1,6,i)-x(1,k))/ro(6), (newSatpos(2,6,i)-x(2,k))/ro(6), (newSatpos(3,6,i)-x(3,k))/ro(6),1
%                                     (newSatpos(1,7,i)-x(1,k))/ro(7), (newSatpos(2,7,i)-x(2,k))/ro(7), (newSatpos(3,7,i)-x(3,k))/ro(7),1
%                                     (newSatpos(1,8,i)-x(1,k))/ro(8), (newSatpos(2,8,i)-x(2,k))/ro(8), (newSatpos(3,8,i)-x(3,k))/ro(8),1]);
%                                 
%   deltaX = (G'*R*G)\G'*R*deltaP;
% x(1,k+1) = x(1,1)+deltaX(1);
% x(2,k+1) = x(2,1) + deltaX(2);
% x(3,k+1) = x(3,1) + deltaX(3);
% x(4,k+1) = x(4,1) - deltaX(4);
% end

% 
% for i = 2:iterations
% for k=1:10
%     
%   for j =1:8
%  ro(j) = sqrt( (-x_last(1)+x(1))^2 +(-x_last(2)+x(2))^2 + (-x_last(3)+x(3))^2) ;
% P_hat(j) =sqrt( (-newSatpos(1,j,i)+x(1))^2 +(-newSatpos(2,j,i)+x(2))^2 + (-newSatpos(3,j,i)+x(3))^2)+ c*x(4);
% deltaP(j) =P_hat(j) - newPR(j,i);            
%   end
% 
% G =([(newSatpos(1,1,i)-x(1))/ro(1), (newSatpos(2,1,i)-x(2))/ro(1), (newSatpos(3,1,i)-x(3))/ro(1),1
%                                     (newSatpos(1,2,i)-x(1))/ro(2), (newSatpos(2,2,i)-x(2))/ro(2), (newSatpos(3,2,i)-x(3))/ro(2),1
%                                     (newSatpos(1,3,i)-x(1))/ro(3), (newSatpos(2,3,i)-x(2))/ro(3), (newSatpos(3,3,i)-x(3))/ro(3),1
%                                     (newSatpos(1,4,i)-x(1))/ro(4), (newSatpos(2,4,i)-x(2))/ro(4), (newSatpos(3,4,i)-x(3))/ro(4),1
%                                     (newSatpos(1,5,i)-x(1))/ro(5), (newSatpos(2,5,i)-x(2))/ro(5), (newSatpos(3,5,i)-x(3))/ro(5),1
%                                     (newSatpos(1,6,i)-x(1))/ro(6), (newSatpos(2,6,i)-x(2))/ro(6), (newSatpos(3,6,i)-x(3))/ro(6),1
%                                     (newSatpos(1,7,i)-x(1))/ro(7), (newSatpos(2,7,i)-x(2))/ro(7), (newSatpos(3,7,i)-x(3))/ro(7),1
%                                     (newSatpos(1,8,i)-x(1))/ro(8), (newSatpos(2,8,i)-x(2))/ro(8), (newSatpos(3,8,i)-x(3))/ro(8),1]);
%                                 
%   deltaX = (G'*R*G)\G'*R*deltaP;
%  x(1) = x(1)+deltaX(1);
% x(2) = x(2) + deltaX(2);
% x(3) = x(3) + deltaX(3);
% x(4) = x(4) - deltaX(4);
% 
% end
% end