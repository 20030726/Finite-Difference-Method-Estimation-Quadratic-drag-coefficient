function [X_noisy, Z_noisy] = addNormalNoise(X, Z, sigma, mu)
    % Function to add Gaussian noise to matrices X and Z
    % Input:
    %   X, Z - Input data matrices to which noise will be added
    %   sigma - Standard deviation of the Gaussian noise
    %   mu - Mean of the Gaussian noise

    % Generate noise for X
    noise_X = sigma .* generateNormalRandomNumbers(size(X), mu, sigma);
    noise_X(1) = 0;  % Ensuring the first element is zero if needed
    X_noisy = X + noise_X;  % Add noise to X

    % Generate noise for Z
    noise_Z = sigma .* generateNormalRandomNumbers(size(Z), mu, sigma);
    noise_Z(1) = 0;  % Ensuring the first element is zero if needed
    Z_noisy = Z + noise_Z;  % Add noise to Z

end
