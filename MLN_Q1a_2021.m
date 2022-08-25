% Back Propogation algorithm
clc; 
clear all;
close all;
x(1)=0;
for i=1:1000 
    u(i)=2*rand-1; 
    x(i+1)=(x(i)/(1+x(i)^2))+(u(i))^3;
    I(1,i)=x(i);
    I(2,i)=u(1,i);
    yd(i)=x(i+1); 
end

% Initiate random weights
w1=rand(10,3);
w2=rand(11,1);
x1=rand(1000);
x2=rand(1000);

eta=0.009;

%% Training 
for i=1:1000 %iterations
    b(1,2)=rand;
    for j=1:10
        h(j)=b(1)*w1(j,1)+x1(i)*w1(j,2)+x2(i)*w1(j,3);
        x(j)=sigma(h(j));
    end
    sum=0;
    for j=2:11
        s(j-1)=x(j-1)*w2(j,1);
        sum=sum+s(j-1);
    end
    q=sum+b(2)*w2(1,1);
    y(i)=sigma(q);   
end
for i=1:1000 
    delta3=y(i)*(1-y(i))*(yd(i)-y(i));
    for j=1:10
        delta2(j)=x(j)*(1-x(j))*w2(j+1,1)*delta3;
    end
        for k=1:3
            if k==1 % for bias
                for n=1:10
                     w1(n,k)=w1(n,k)+ eta*b(1)*delta2(n);
                     w2(n,1)=w2(n,1)+ eta*b(2)*delta3;
                end
            else
                if k==2
                    for n=1:10
                        w1(n,k)=w1(n,k)+eta*x1(i)*delta2(n);
                        w2(n,1)=w2(n,1)+eta*x(i)*delta3;
                    end
                else 
                    for n=1:10
                        w1(n,k)=w1(n,k)+eta*x2(i)*delta2(n);
                        w2(n,1)=w2(n,1)+eta*x(i)*delta3;
                    end
                end
            end
        end
        TRerror(i)=0.5*(yd(i)-y(i))^2;
end
%% Testing
for i=1:1000 
    xx(1)=0.5;
    u(i)=sin(0.2*i); 
    xx(i+1)=(xx(i)/(1+xx(i)^2))+(u(i))^3;
    x1(i)=xx(i);
    x2(i)=u(i);
    yd1(i)=xx(i+1); 
end
for i=1:1000 %iterations
    for j=1:10
        h(j)=b(1)*w1(j,1)+x1(i)*w1(j,2)+x2(i)*w1(j,3);
        x(j)=sigma(h(j));
    end
    sum=0;
    for j=2:11
        s(j-1)=x(j-1)*w2(j,1);
        sum=sum+s(j-1);
    end
    q=sum+b(2)*w2(1,1);
    y1(i)=sigma(q);   
end

%% Plotting
figure(2);
subplot(2,1,1);
plot(yd1);
xlabel('Sampling Instant');
ylabel('yd1');
title('Desired output for given input','r');
subplot(2,1,2);
plot(y1);
xlabel('Sampling Instant');
ylabel('y1');
title('Output during testing','r');

