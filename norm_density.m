% Compute density of the normal distribution function
% Inputs: 
% x - vector of points for which to calculate the normal CDF
% mu - mean of the normal
% sigma - std dev of the normal

p = exp( -(x-mu).^2 / (2*sigma^2) ) / (sigma * sqrt(2*pi) );