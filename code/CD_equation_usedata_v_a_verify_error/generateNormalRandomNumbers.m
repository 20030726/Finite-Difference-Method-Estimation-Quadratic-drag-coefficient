function Z = generateNormalRandomNumbers(dimensions, mu, sigma) % only 2-D matrix
seed = 1234;        % Initial seed X(1)
a = 1664525;        % Multiplier
c = 1013904223;     % Increment
m = 2^32;           % Modulus
A = dimensions(1);
B = dimensions(2);
n = 2*A*B;            % Number of uniformly distributed random numbers to generate

%% Generate uniformly distributed random numbers
U = zeros(n, 1);
X = seed;
for i = 1:n
    X = mod(a * X + c, m);
    U(i) = X / m;  % Scale random numbers to [lower, upper) interval
end

%% Box-Muller transform
Z = zeros(A, B);
index = 1;
for i = 1:A
    for j = 1:B
        Z(i,j) = mu + sigma * sqrt(-2 * log(U(index))) * cos(2 * pi * U(index+1));
        %Z(i,j) = mu + sigma * sqrt(-2 * log(U(index))) * sin(2 * pi * U(index+1));
        index = index + 2;
    end
end

end