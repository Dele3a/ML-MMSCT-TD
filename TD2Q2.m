clear; clc; close all

% Load all variables from file
load('DataTP3.mat');

K = 4;
[idx, C] = kmeans(X, K);

figure(1);
gscatter(X(:,1), X(:,2), idx); 
hold on;
