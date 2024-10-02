function [RMSE, MSE] = calculateRMSE(N, A)
    % Function to calculate the Root Mean Squared Error (RMSE) and Mean Squared Error (MSE)
    % between the estimated values and the true values.
    % 
    % Inputs:
    %   N - Vector of estimated values
    %   A - Vector of true values
    %
    % Outputs:
    %   RMSE - Root Mean Squared Error
    %   MSE - Mean Squared Error

    % Calculate the squared differences
    squared_diff = (N - A).^2;

    % Calculate the Mean Squared Error (MSE)
    MSE = mean(squared_diff);

    % Calculate the Root Mean Squared Error (RMSE)
    RMSE = sqrt(MSE);

end
