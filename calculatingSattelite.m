load('Lab1Data.mat')

%first we decide upon which of the sattelites that are visible the entire
%time the reciever is recieving data.

visible = ones(32,1);

for i=1:32
    for j =1:7200
        if EL(i,j)==0
            visible(i) =0;
            break;
        end
    end
end

visible

%the ones that are visible are:

for i=1:32
    if visible(i) ==1
        disp (i)
    end
end
%1, 11, 13, 17 , 20, 23, 31 and 32 are visible in the entire time period.