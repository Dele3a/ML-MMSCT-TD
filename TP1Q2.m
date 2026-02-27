clear; clc; close all


%Parameters
N=20;
M=1000;
D=2;

%Input
All_input=2*rand(D,M)-1;
%target
All_output = sqrt(sum(All_input.^2));

%Define a network
trainFcn= 'trainlm';
hiddenLayer1Size=10;
hiddenLayer2Size=10;
net=fitnet([hiddenLayer1Size hiddenLayer2Size],trainFcn);
hold on
net=train(net,All_input,All_output);
predicted_output = net(All_input);
ERR = mean((predicted_output - All_output).^2);
disp(['Error: ', num2str(ERR)]);

figure;
hold on;
plot3(All_input(1,:), All_input(2,:), All_output, 'bo'); 
plot3(All_input(1,:), All_input(2,:), predicted_output, 'rx'); 
