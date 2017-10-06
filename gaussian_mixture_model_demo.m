% Tests out gaussian_mixture_model
%
% set parameters to 3 classes, maxIterations, and load the data file

C = 5;
maxIterations = 5000;
data = load('test_hist_steph.mat');
% data = load('daniel_hist2.mat')

X = data.file2; % this particular dataset is loaded as a struct 
[m, n] = size(X);
numData = n
X = X.';
setAIC = true; % boolean: get the best model using AIC scoring on 1 to C number of mixtures
[numComponents, BestModel] = gaussian_mixture_model(X, C, maxIterations, setAIC); % run GMM

% plot the results
xmin = min(X);
xmax = max(X);
[counts, bins] = hist(X,100);

est_pdf = counts / sum(counts * mean(diff(bins)));

pd = BestModel;
x_pdf = linspace(xmin, xmax, 1000);
y_pdf = pdf(pd, x_pdf');

figure;
hold on;
bar(bins, est_pdf);
plot(x_pdf, y_pdf, '-r', 'Linewidth', 2);
hold off;