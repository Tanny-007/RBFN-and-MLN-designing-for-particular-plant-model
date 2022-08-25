

clc;
clear all;
close all;
data=1000;
eta=0.009;
x(1)=0.5;
% generating 1000 inputs and corresponding outputs
for i=1:data 
    u(i)=2*rand-1; 
    x(i+1)=(x(i)/(1+x(i)^2))+(u(i))^3;
    I(1,i)=x(i);
    I(2,i)=u(1,i);
    yd(i)=x(i+1);   %since y(1)=X(2)=(x(1)+(1+x(1)^2))+u(1)^3
end
% Initialising 100 centers,weights and sigma
for i=1:100
    c(1,i)=rand;
    c(2,i)=rand;
    w(i)=rand;
    sg(i)=rand;
end

%% Training
for n=1:100 
    for k=1:1000
        sum=0;
        for i=1:100
            z(i)=norm(I(:,k)-c(:,i));
            phi(i)=exp(-((z(i))^2/(2*(sg(i))^2)));
            sum=sum+(phi(i)*w(i));
        end
        I(:,k);
        y(k)=sum;
        % Updating weights centers and sigma
        for j=1:100
            w(j)=w(j)+eta*(yd(k)-y(k))*phi(j);
            c(:,j)=c(:,j)+((eta/sg(j)^2)*(yd(k)-y(k))*w(j)*phi(j)*(I(:,k)-c(:,j)));
            sg(j)=sg(j)+(eta/(sg(j))^3)*(yd(k)-y(k))*w(j)*phi(j)*((norm(I(:,k)-c(:,j)))^2);
        end
    end
    TRerror(n)=0.5*(yd(k)-y(k))^2;
end
figure(1);
plot(TRerror);


%% Testing
for i=1:1000 
    u(i)=sin(0.2*i); 
    x(i+1)=(x(i)/(1+x(i)^2))+(u(i))^3;
    I(1,i)=x(i);
    I(2,i)=u(1,i);
    yd1(i)=x(i+1);   %since y(1)=X(2)=(x(1)+(1+x(1)^2))+u(1)^3
end
for i=1:1000
    sum=0;
    for k=1:100
      z(k)=norm(I(:,i)-c(:,k));
      phi(k)=exp(-((z(k))^2/(2*(sg(k)^2))));
      sum=sum+(phi(k)*w(k));
    end
    y1(i)=sum; %y1=y(501:1000)
end
figure(2);
subplot(2,1,1);
plot(yd);
xlabel('Sampling Instant');
ylabel('yd');
title('Desired output','r');
subplot(2,1,2);
plot(y);
xlabel('Sampling Instant');
ylabel('y');
title('Output durinng training','r');

figure(3);
subplot(3,1,1);
plot(yd1);
xlabel('Sampling Instant');
ylabel('yd1');
title('Desired output for given input','r');
subplot(3,1,2);
plot(y1);
xlabel('Sampling Instant');
ylabel('y1');
title('Output during testing','r');



