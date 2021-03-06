%calculating the pseudoranges for sattelites 1, 11, 13, 17 , 20, 23, 31 and 32
%fist we assume the reciever is positioned at the centre of the world
clear;
clc;

load('Lab1Data.mat');

%initializing

R =eye(32);
c=299792458;



% 
% G= zeros(8,4);
% deltax=[0;0;0;0];
% deltax=inv(transpose(G)*G)*transpose(G)*deltaP;
% x_hat(i) =x(i-1)+deltax; 
% x_hat = [0;0;0;0]
x=zeros(4,1);
iterations=7200;
 deltaP=zeros(32,1);
 P_hat = zeros(32,1);
 deltaX=zeros(4,1);
 ro = zeros(32,1);
 G=zeros(32,4);
% saving the dataset;
errorNorm=zeros(iterations,1);
sol=zeros(4,iterations);

for i=1:iterations
   sol(:,i)=x;
   errorNorm (i)= norm(P0-x(1:3));
            for k=1:10

            for j =1:32
                 currentSize = 0;
                if (EL(j,i)  >5)
                      ro (j) = sqrt( (-Satpos(1,j,i)+x(1))^2+(-Satpos(2,j,i)+x(2))^2+(-Satpos(3,j,i)+x(3))^2);
                      P_hat (j) =  ro(j)+c*x(4);
                      deltaP(j) = P_hat(j) - PR(j,i);
                        for m=1:3
                        G(j,m)= (Satpos(m,j,i)-x(m))/ro(j);
                        end
                        G(j,4)=1;   
                end
            end
                                        deltaX = inv(transpose(G)*inv(R)*G)*transpose(G)*inv(R)*deltaP;
                                        x(1) = x(1) + deltaX(1);
                                        x(2) = x(2) + deltaX(2);
                                        x(3) = x(3) + deltaX(3);
                                        x(4) = x(4) - deltaX(4)/c;
            end


end
plot(errorNorm(2:iterations))


