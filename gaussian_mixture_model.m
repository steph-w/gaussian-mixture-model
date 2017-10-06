function [numComponents, BestModel] = ...
    gaussian_mixture_model(X, C, maxIterations, setAIC)

% gaussian_mixture_model.m
%
% inputs:
% X - values 
% C - number of classes/ components
% maxIterations - max number of iterations to run EM
% setAIC - boolean specifies whether or not to use AIC scoring to return
% the best fit model and the number of components in the model
%
% outputs:
% numComponents - number of components in the model
% BestModel - if setAIC is 'true', then BestModel is the best scoring model
% with the lowest AIC score. Else if setAIC is 'false' then simply returns
% the model found.
%

if setAIC == false
    try
        GMM = fitgmdist(X, C);
        numComponents = C
        BestModel = GMM
    catch exception
        disp('There was an error fitting the Gaussian mixture model')
        error = exception.message
    end
else
    AIC = zeros(1, C);
    GMModels = cell(1, C);
    options = statset('MaxIter', maxIterations);
    for k = 1:C
        GMModels{k} = fitgmdist(X, k, 'Options', options, 'CovarianceType', 'diagonal');
        AIC(k) = GMModels{k}.AIC;
    end

    [minAIC, numComponents] = min(AIC);

    numComponents

    BestModel = GMModels{numComponents}
    
end
