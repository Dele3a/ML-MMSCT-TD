clear; clc; close all


load('DataTP3_Q2.mat');
K = 3;
M = 5;  

figure;

for k = 1:K
    % Get cluster data
    Xk = X(idx == k, :)';
    
    subplot(2,5,k)
    
    if size(Xk, 2) < 2
        title(['Cluster ' num2str(k) ' empty'])
        continue
    end
    
    % STEP 1: POD basis 
    Xk_mean = mean(Xk, 2);
    Xk_c = Xk - Xk_mean;
    [U, ~, ~] = svd(Xk_c, 'econ');
    Phi = U(:, 1:M);  
    
  
    a_reduced = Phi' * Xk_c; 
    
   
    plot(a_reduced(1,:), a_reduced(2,:), 'b.', 'MarkerSize', 12)
    
    title(['Cluster ' num2str(k)])
    xlabel('Mode 1')
    ylabel('Mode 2')
    grid on
    axis equal
end

sgtitle(['Q4: POD Projection in Plane (M=' num2str(M) ' modes)'])
