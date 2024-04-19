% Script to generate 200 damage cases for a train infrastructure simulation
% Note that we generate continous damage factor values between 0.7 and 1.0, whereas in the 
% original PTAE paper, the damage factor is discretized into 3 levels: 0.9, 0.8 and 0.7.

addpath(genpath('simulation'));
addpath(genpath('func'));

% Number of damage cases to generate
num_cases = 200;

% Normal distribution parameters for the damage factor
mu = 0.85; % Estimated mean (centered between 0.7 and 1.0)
sigma = (1.0 - 0.7) / 6; % Standard deviation set to place 99.7% of data within [0.7, 1.0]

% Preallocate array for damage factors
damage_factors = zeros(1, num_cases);

% Generate damage factors using truncated normal distribution
for i = 1:num_cases
    while true
        temp = normrnd(mu, sigma);
        if temp >= 0.7 && temp <= 1.0
            damage_factors(i) = temp;
            break;
        end
    end
end

% Loop to simulate each damage case
for i = 1:num_cases
    fprintf('Running damage case %d with damage factor %.2f...\n', i, damage_factors(i));
    simulate_single_train_run(damage_factors(i), i); 
end

fprintf('All %d damage simulations completed.\n', num_cases);
