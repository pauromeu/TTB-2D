function ET = get_stiffness_by_temp(seed, E0, T)
    % concreteElasticModulus calculates the temperature-dependent elastic modulus of concrete.
    %
    % Input:
    %   seed - Seed for the random number generator for reproducibility
    %   E0 - Reference elastic modulus
    %   T - Temperature in degrees Celsius
    %
    % Output:
    %   ET - Temperature-dependent elastic modulus

    % Define the mean (mu) and standard deviation (sigma) for Q, S, K, tau, and R
    mu = struct('Q', 1.0129, 'S', -0.0048, 'K', 0.1977, 'tau', 3.1466, 'R', 0.1977);
    sigma = struct('Q', 0.003, 'S', 0.0001, 'K', 0.0027, 'tau', 0.0861, 'R', 0.0027);
    
    % Set the seed for the random number generator
    rng(seed);
    
    % Sample from normal distributions based on the given mean and standard deviations
    Q = normrnd(mu.Q, sigma.Q);
    S = normrnd(mu.S, sigma.S);
    K = normrnd(mu.K, sigma.K);
    tau = normrnd(mu.tau, sigma.tau);
    R = normrnd(mu.R, sigma.R);
    
    % Calculate the temperature-dependent elastic modulus ET
    ET = E0 * (Q + S * T + R * (1 - erf((T - K) / tau)));
end
