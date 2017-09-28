% Tests out gaussian_mixture_model
%
% set parameters to 3 classes, maxIterations, and load the data file

C = 4;
maxIterations = 5000;
data = load("test_hist_steph.mat");
X = data.file2; % this particular dataset is loaded as a struct 
X = X.';
setAIC = true; % boolean: get the best model using AIC scoring on 1 to C number of mixtures
[numComponents, BestModel] = gaussian_mixture_model(X, C, maxIterations, setAIC) % run GMM


% plot the results
num = length(X);
factor = round(0.9*num);
histogram(X,linspace(0,1,factor), 'EdgeColor', 'blue')

hold on
x = linspace(0,1,factor);
for i = 1:C
    norm = normpdf(x, BestModel.mu(i), sqrt(BestModel.Sigma(i)));
    plot(x, norm, 'Linewidth', 2)
end