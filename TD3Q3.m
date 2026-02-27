function TD3Q3()
    

    rng(1);         % reproducible
    N = 40;

    
    load('dataset_Q2.mat', 'X', 'y');   % from TD3Q2
    numSamples = size(X, 1);
    
    fprintf('Loaded dataset: %d images\n', numSamples);

 
    T = full(ind2vec(y'));   % size (3, numSamples)

    % Split: 80% train, 20% validation
    nTrain = round(0.8 * numSamples);
    fprintf('Train: %d images, Validation: %d images\n', nTrain, numSamples-nTrain);

    X_train = X(1:nTrain, :)';
    T_train = T(:, 1:nTrain);
    X_val   = X(nTrain+1:end, :)';
    T_val   = T(:, nTrain+1:end);

    % ========== 2) NETWORK (a): 1 HIDDEN LAYER ==========
    fprintf('\n--- Network (a): 1 hidden layer, 10 neurons ---\n');
    net1 = patternnet(10);              % 1 layer, 10 neurons
    net1.trainParam.showWindow = false; % no GUI popup
    net1.trainParam.epochs = 200;
    net1.divideFcn = 'dividetrain';     % manual validation
    net1 = train(net1, X_train, T_train);

    % Validation error
    err1_val = compute_error(net1, X_val, T_val);
    fprintf('Validation error net1: %.2f %%\n', err1_val);

    % ========== 3) NETWORK (b): 2 HIDDEN LAYERS ==========
    fprintf('\n--- Network (b): 2 hidden layers, 10 neurons each ---\n');
    net2 = patternnet([10 10]);         % 2 layers, 10 neurons each
    net2.trainParam.showWindow = false;
    net2.trainParam.epochs = 200;
    net2.divideFcn = 'dividetrain';
    net2 = train(net2, X_train, T_train);

    % Validation error
    err2_val = compute_error(net2, X_val, T_val);
    fprintf('Validation error net2: %.2f %%\n', err2_val);

    % ========== 4) TEST ON 15 NEW RANDOM SHAPES ==========
    fprintf('\n--- Testing on 15 new random shapes ---\n');
    
    Ntest = 15;
    X_test = zeros(N*N, Ntest);
    y_test = zeros(1, Ntest);   % integer labels for test

    for k = 1:Ntest
        [img, lab] = random_shape(N);
        X_test(:, k) = img(:);
        y_test(k) = lab;
    end

    % Error on new shapes
    err1_test = compute_error_labels(net1, X_test, y_test);
    err2_test = compute_error_labels(net2, X_test, y_test);

    % ========== 5) FINAL RESULTS TABLE ==========
    fprintf('\n=== RESULTS ON 15 NEW TEST SHAPES ===\n');
    fprintf('Network\t\tHidden layers\tError %%\n');
    fprintf('net1\t\t1\t\t%.2f\n', err1_test);
    fprintf('net2\t\t2\t\t%.2f\n', err2_test);

    % Save results
    save('results_Q3.mat', 'net1', 'net2', 'err1_test', 'err2_test', 'X_test', 'y_test');
    fprintf('\nResults saved as results_Q3.mat\n');
end



function err = compute_error(net, X_val, T_val)
    Y_val = net(X_val);
    [~, pred]  = max(Y_val, [], 1);
    [~, truth] = max(T_val, [], 1);
    err = mean(pred ~= truth) * 100;
end

function err = compute_error_labels(net, X_test, y_test)
    Y_test = net(X_test);
    [~, pred] = max(Y_test, [], 1);
    err = mean(pred ~= y_test) * 100;
end

function [img, label] = random_shape(N)
    label = randi([1,3], 1, 1);  % 1=circle, 2=square, 3=band
    switch label
        case 1
            img = random_circle(N, 5, 12);
        case 2
            img = random_square(N, 8, 16);
        case 3
            img = random_band(N, 5, 15);
    end
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
