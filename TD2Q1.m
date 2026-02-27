
%Prepare a report on TP1,TP2,TP3 (Deadline : March 1)
clear; clc; close all

% Load all variables from file
load('DataTP3.mat');

K = 3;
[idx, C] = kmeans(X, K);

figure(1);
gscatter(X(:,1), X(:,2), idx); 
hold on;


plot(C(:,1), C(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);


plot(X(idx==2, 1), X(idx==2, 2), 'b.', 'MarkerSize', 12);

hold off;
axis equal; grid on;


figure(2);
silhouette(X, idx); 
title('Silhouette Plot');