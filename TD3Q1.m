function TD3Q1()
    

    N = 40;      % image size

    img_circle = random_circle(N, 5, 12);
    img_square = random_square(N, 8, 16);
    img_band   = random_band(N, 5, 15);

    % Display the 3 images
    figure;
    subplot(1,3,1); imagesc(img_circle); axis image off; title('Circle');
    subplot(1,3,2); imagesc(img_square); axis image off; title('Square');
    subplot(1,3,3); imagesc(img_band);   axis image off; title('Band');
    colormap gray;
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
