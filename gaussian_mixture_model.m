function [mu_est, sigma_est, p_est, counter, difference] = gaussian_mixture_model(values, k, epsilon, iterations)

% Estimate the parameters of a 1D gaussian mixture model using EM
% Inputs:
% values - row vector training set or observed values
% k - number of classes (mixtures)
% epsilon - precision for convergence
% iterations - max iterations to run
%
% Outputs:
% mu_est - vector output of mean estimates for each class
% sigma_est - vector output of standard deviations for each class
% p_est - class membership probability estimates
% counter - number of iterations needed for convergence
% difference - total absolute difference in parameters at each iteration to
% get an idea of the convergence rate

% initialize
counter = 0;
mu_est = ones([k, 1]) * mean(values);
sigma_est = ones([k, 1]) * std(values);
p_est = ones(C, 1) / C;
difference = epsilon;

while (difference >= epsilon && counter < iterations)
    % E step soft classify values into one of the classes: 
    for j=1:k
        class(j, :) = norm_density(values, sigma_est(j), mu_est(j)) * p_est(j);
    end
    % normalize
    class = class ./ repmat(sum(class), C, 1);
    
    % M step estimate the parameters ( p, u, sigma )
    mu_est_old = mu_est;
    sigma_est_old = sigma_est;
    p_est_old = p_est;
    for j=1:k
        mu_est(j) = sum( class(j,:).*values ) / sum(class(j,:));
        sigma_est(j) = sqrt( sum(class(j,:).*(values - mu_est(j)).^2) / sum(class(j,:)) );
        p_est(j) = mean(class(j,:));
    end
    
    difference(counter+1) = sum(abs(mu_est_old - mu_est)) + sum(abs(sigma_est_old - sigma_est)) + sum(abs(p_est_old - p_est));
        
    counter = counter + 1;
end