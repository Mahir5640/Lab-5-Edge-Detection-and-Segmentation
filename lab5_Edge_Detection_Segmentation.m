%% Lab 5: Edge Detection and Segmentation
close all; clear; clc;

lab5Folder = fileparts(mfilename('fullpath'));
outputDir = fullfile(lab5Folder, 'screenshots');
if ~isfolder(outputDir)
    mkdir(outputDir);
end

I = im2double(rgb2gray(imread('peppers.png')));

%% 1) Gradient-based edges: Sobel and Prewitt
edges_sobel = edge(I, 'Sobel');
edges_prewitt = edge(I, 'Prewitt');

fig = figure('Position', [100 100 1200 400]);
subplot(1,3,1); imshow(I, [0 1]); title('Original grayscale image');
subplot(1,3,2); imshow(edges_sobel); title('Sobel edges');
subplot(1,3,3); imshow(edges_prewitt); title('Prewitt edges');
exportgraphics(fig, fullfile(outputDir, '01-sobel-prewitt.png'));

%% 2) Canny edge detection
edges_canny = edge(I, 'Canny', [0.05 0.20]);

fig = figure('Position', [100 100 900 400]);
subplot(1,2,1); imshow(I, [0 1]); title('Original grayscale image');
subplot(1,2,2); imshow(edges_canny); title('Canny edges');
exportgraphics(fig, fullfile(outputDir, '02-canny.png'));

%% 3) Laplacian of Gaussian zero-crossing detection
edges_log = edge(I, 'log');

fig = figure('Position', [100 100 900 400]);
subplot(1,2,1); imshow(edges_canny); title('Canny edges');
subplot(1,2,2); imshow(edges_log); title('Laplacian of Gaussian edges');
exportgraphics(fig, fullfile(outputDir, '03-log.png'));

%% 4) Segment the grayscale image with Otsu thresholding
level = graythresh(I);
BW = imbinarize(I, level);

fig = figure('Position', [100 100 900 400]);
subplot(1,2,1); imshow(I, [0 1]); title('Original grayscale image');
subplot(1,2,2); imshow(BW);
title(sprintf('Otsu mask, threshold = %.4f', level));
exportgraphics(fig, fullfile(outputDir, '04-otsu-mask.png'));

%% 5) Label connected foreground regions
[L, numRegions] = bwlabel(BW, 8);
RGB = label2rgb(L, 'jet', 'k', 'noshuffle');

fig = figure('Position', [100 100 900 400]);
subplot(1,2,1); imshow(BW); title('Otsu binary mask');
subplot(1,2,2); imshow(RGB);
title(sprintf('Labeled regions: %d', numRegions));
exportgraphics(fig, fullfile(outputDir, '05-labeled-regions.png'));

%% 6) Reflection answers are in README.md
fprintf('Otsu threshold: %.4f\n', level);
fprintf('Connected foreground regions: %d\n', numRegions);
fprintf('Figures saved to %s\n', outputDir);