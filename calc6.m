%calculating the pseudoranges for sattelites 1, 11, 13, 17 , 20, 23, 31 and 32
%fist we assume the reciever is positioned at the centre of the world
clear;
clc;

load('Lab1Data.mat');

%initializing

 %R = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
 R =eye(8);
c=299792458;
newSatpos=zeros(3,8,7200);
newEL = zeros(8,7200);
newPR= zeros(8,7200);
j=1;

%making New data from only sattelites which are in use
for i = [1,11,13,17,20,23,31,32]
newSatpos(:,j,:)=Satpos(:,i,:);
newEL(j,:) = EL(i,:);
newPR(j,:)=PR(i,:);
j=j+1;
end


% 
% G= zeros(8,4);
% deltax=[0;0;0;0];
% deltax=inv(transpose(G)*G)*transpose(G)*deltaP;
% x_hat(i) =x(i-1)+deltax; 
% x_hat = [0;0;0;0]
x = [0;0;0;0];

iterations=20;
 deltaP=zeros(8,1);
 P_hat = zeros(8,1);
 deltaX=zeros(4,1);
 ro = zeros(8,1);
 
% saving the dataset;
sol =zeros(4,iterations);
sol_inside =zeros(4,iterations*10);
time = [0:0.5:iterations/2];
for i=1:iterations
    %saving new measurement for each time step/iteration....
         sol(:,i)=x;
         
         %iterating 10 times for each time step.
             for k = 1:10
               sol_inside(:,k+(i-1)*10)=x;
   %calculate 
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

                                                          % deltaX = inv(transpose(G)*inv(R)*G)*transpose(G)*inv(R)*deltaP;
                                                          Q=G'*G;
                                                          deltaX=Q\(G'*deltaP);
                                                            x(1) = x(1) + deltaX(1);
                                                            x(2) = x(2) + deltaX(2);
                                                            x(3) = x(3) + deltaX(3);
                                                            x(4) = x(4) - deltaX(4);

             end
end



