clear; clc; close all

load('DataTP3_Q2.mat');

K = 3;  % number of clusters

figure;  % ONE FIGURE

for k = 1:K
    % Get data from cluster k
    data_cluster = X(idx == k, :)';  % D x N matrix
    
    if size(data_cluster, 2) < 2
        subplot(2,5,k)
        title(['Cluster ' num2str(k) ' empty'])
        continue
    end
    
    % STEP 1: POD 
    mean_data = mean(data_cluster, 2);
    data_centered = data_cluster - mean_data;
    [U, S, V] = svd(data_centered, 'econ');
    
    % STEP 2: Eigenvalues
    eigenvalues = (diag(S).^2 / sum(diag(S).^2)) * 100;
    
    % STEP 3: Find modes for errors
    cum_energy = cumsum(eigenvalues);
    mode_10err = find(cum_energy >= 90, 1);  
    mode_5err  = find(cum_energy >= 95, 1);  
    
    % PLOT
    subplot(2,5,k)
    semilogy(eigenvalues, 'b-o', 'LineWidth', 3, 'MarkerSize', 8)
    hold on
    
    % MARK 10% ERROR 
    plot(mode_10err, eigenvalues(mode_10err), 'go', 'MarkerSize', 15)
    text(mode_10err, eigenvalues(mode_10err), ...
         ['10%err: ' num2str(mode_10err)], 'FontSize', 12)
    
    % MARK 5% ERROR 
    plot(mode_5err, eigenvalues(mode_5err), 'ro', 'MarkerSize', 15)
    text(mode_5err, eigenvalues(mode_5err), ...
         ['5%err: ' num2str(mode_5err)], 'FontSize', 12)
    
    title(['Cluster ' num2str(k)])
    ylabel('% Energy')
    grid on
end

sgtitle('Q3: POD Eigenvalues')

% PRINT RESULTS
fprintf('\nRESULTS Q3:\n')
fprintf('Cluster | 10%% error | 5%% error\n')
for k = 1:K
    if sum(idx==k) > 1
        data_cluster = X(idx == k, :)';
        mean_data = mean(data_cluster, 2);
        data_centered = data_cluster - mean_data;
        [~, S, ~] = svd(data_centered, 'econ');
        eigenvalues = (diag(S).^2 / sum(diag(S).^2)) * 100;
        cum_energy = cumsum(eigenvalues);
        mode_10 = find(cum_energy >= 90, 1);
        mode_5  = find(cum_energy >= 95, 1);
        fprintf('%d       |    %d     |   %d    \n', k, mode_10, mode_5)
    else
        fprintf('%d       | empty           \n', k)
    end
end
