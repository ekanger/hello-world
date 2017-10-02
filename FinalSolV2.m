%calculating the pseudoranges for sattelites 1, 11, 13, 17 , 20, 23, 31 and 32
%fist we assume the reciever is positioned at the centre of the world
clear;
clc;

load('Lab1Data.mat');

%initializing

R =eye(8);
c=299792458;



% 
% G= zeros(8,4);
% deltax=[0;0;0;0];
% deltax=inv(transpose(G)*G)*transpose(G)*deltaP;
% x_hat(i) =x(i-1)+deltax; 
% x_hat = [0;0;0;0]
x=zeros(4,1);
iterations=7200;
 deltaP=zeros(8,1);
 P_hat = zeros(8,1);
 deltaX=zeros(4,1);
 ro = zeros(8,1);
 
% saving the dataset;
sol =zeros(4,iterations);

newTime=zeros(1,iterations);
error = zeros(3,iterations);
% saving the dataset;
sol =zeros(4,iterations);
errorNorm=zeros(1,iterations);

for i=1:iterations
    %saving new measurement for each time step/iteration....
         sol(:,i)=x;
         error(:,i) = (P0-x(1:3));
     errorNorm (i)= norm(P0-x(1:3));
     
     %determining what sattelites to use data from in this i
     
     
         %iterating 10 times for each time step.
             for k = 1:10
                            %for each of the 8 visible sattelites, we
                            %calculate 
                             for j = 1:8
                               ro (j) = sqrt( (-newSatpos(1,j,i)+x(1))^2+(-newSatpos(2,j,i)+x(2))^2+(-newSatpos(3,j,i)+x(3))^2);
                               end

                                                           for j=1:8
                                                           P_hat (j) =  ro(j)+c*x(4);
                                                           end
                               deltaP = P_hat - newPR(:,i);
  
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
                                x(4) = x(4) - deltaX(4)/c;

       
       % deltaX = inv(G*inv(R)*transpose(G))*G*R*(deltaP)
    end
end
plot(errorNorm(2:iterations))
            
 
       

%   ro(j,i)=sqrt( (x_0(1)-newSatpos(1,j,i))^2 +(x_0(2)-newSatpos(2,j,i))^2 + (x_0(3)-newSatpos(3,j,i))^2) ;
%  
%  P_hat(i)=sqrt( (x_0(1)-newSatpos(1,j,i))^2 +(x_0(2)-newSatpos(2,j,i))^2 + (x_0(3)-newSatpos(3,j,i))^2)
% 
%   p-PR(1,1)

%   G =[(newSatpos(1,1,i)-x_0(1))/newPR(1,i)(newSatpos(2,1,i)-x_0(2))/newPR(1,i),(newSatpos(3,1,i)-x_0(3))/newPR(1,i),1
%            newSatpos(1,2,i)-x_0(1),newSatpos(2,2,i)-x_0(2),newSatpos(3,2,i)-x_0(3),1
%            newSatpos(1,3,i)-x_0(1),newSatpos(2,3,i)-x_0(2),newSatpos(3,3,i)-x_0(3),1
%            newSatpos(1,4,i)-x_0(1),newSatpos(2,4,i)-x_0(2),newSatpos(3,4,i)-x_0(3),1
%            newSatpos(1,5,i)-x_0(1),newSatpos(2,5,i)-x_0(2),newSatpos(3,5,i)-x_0(3),1
%            newSatpos(1,6,i)-x_0(1),newSatpos(2,6,i)-x_0(2),newSatpos(3,6,i)-x_0(3),1
%            newSatpos(1,7,i)-x_0(1),newSatpos(2,7,i)-x_0(2),newSatpos(3,7,i)-x_0(3),1
%            newSatpos(1,8,i)-x_0(1),newSatpos(2,8,i)-x_0(2),newSatpos(3,8,i)-x_0(3),1];
% 


