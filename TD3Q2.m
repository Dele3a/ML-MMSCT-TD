function TD3Q2()
   

    rng(1);        
    N = 40;
    M = 50;         


    X = zeros(3*M, N*N);
    y = zeros(3*M, 1);     

    idx = 0;

    % ========== CIRCLES (label 1) ==========
    fprintf('Generating %d circles...\n', M);
    for k = 1:M
        img = random_circle(N, 5, 12);
        idx = idx + 1;
        X(idx, :) = img(:)';   % flatten image to row
        y(idx) = 1;
    end

    % ========== SQUARES (label 2) ==========
    fprintf('Generating %d squares...\n', M);
    for k = 1:M
        img = random_square(N, 8, 16);
        idx = idx + 1;
        X(idx, :) = img(:)';
        y(idx) = 2;
    end

    % ========== BANDS (label 3) ==========
    fprintf('Generating %d bands...\n', M);
    for k = 1:M
        img = random_band(N, 5, 15);
        idx = idx + 1;
        X(idx, :) = img(:)';
        y(idx) = 3;
    end

    % Shuffle the dataset
    perm = randperm(3*M);
    X = X(perm, :);
    y = y(perm);

    % ========== DISPLAY RESULTS ==========
    fprintf('Dataset created: %d images (50 per class)\n', 3*M);
    fprintf('X size: %dx%d, y size: %dx1\n', size(X,1), size(X,2), length(y));

    
    figure;
    Nshow = 6;
    for k = 1:Nshow
        subplot(2,3,k);
        imagesc(reshape(X(k,:), N, N));
        axis image off;
        title(sprintf('Example %d - Label=%d', k, y(k)));
        colormap gray;
    end

    
    save('dataset_Q2.mat', 'X', 'y', 'N');
    fprintf('Dataset saved as dataset_Q2.mat\n');
end



function img = random_circle(N, r_min, r_max)
    img = zeros(N, N);
    r  = randi([r_min, r_max], 1, 1);
    cx = randi([r, N - r], 1, 1);
    cy = randi([r, N - r], 1, 1);
    [x, y] = meshgrid(1:N, 1:N);
    mask = (x - cx).^2 + (y - cy).^2 <= r^2;
    img(mask) = 1;
end

function img = random_square(N, a_min, a_max)
    img = zeros(N, N);
    a  = randi([a_min, a_max], 1, 1);
    x0 = randi([1, N - a], 1, 1);
    y0 = randi([1, N - a], 1, 1);
    img(y0:y0+a-1, x0:x0+a-1) = 1;
end

function img = random_band(N, t_min, t_max)
    img = zeros(N, N);
    t  = randi([t_min, t_max], 1, 1);
    x0 = randi([1, N - t], 1, 1);
    img(:, x0:x0+t-1) = 1;
end
