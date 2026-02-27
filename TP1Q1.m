clear; clc; close all

%Provides a set of 1D data for nonlinear regression
[x,t]=simplefit_dataset;
plot(x,t,'bo')

%Define a network
trainFcn= 'trainlm'; 
type=5
if type==1
    hiddenLayer1Size=2;
    net=fitnet([hiddenLayer1Size],trainFcn);
elseif type==2
    hiddenLayer1Size=4;
    net=fitnet([hiddenLayer1Size],trainFcn);
elseif type==3
    hiddenLayer1Size=10;
    net=fitnet([hiddenLayer1Size],trainFcn);
elseif type==4
    hiddenLayer1Size=5;
    hiddenLayer2Size=5;
    net=fitnet([hiddenLayer1Size hiddenLayer2Size],trainFcn);
else
   hiddenLayer1Size=30;
   hiddenLayer2Size=30;
   net=fitnet([hiddenLayer1Size hiddenLayer2Size],trainFcn); 
end

hold on

x2=1:0.1:9;

%Train the network using x as input and t as output
net=train(net,x,t);

y2=net(x2);


