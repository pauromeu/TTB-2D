% Script to generate 200 damage cases for a train infrastructure simulation

% Number of damage cases to generate
num_cases = 200;

% Normal distribution parameters for the damage factor
mu = 0.85; % Estimated mean (centered between 0.7 and 1.0)
sigma = (1.0 - 0.7) / 6; % Standard deviation set to place 99.7% of data within [0.7, 1.0]

% Preallocate array for damage factors
damage_factors = zeros(1, num_cases);

% Seed for random number generation to ensure reproducibility
base_seed = 31415; % Choose a base seed for all random operations

% Generate damage factors using truncated normal distribution
for i = 1:num_cases
    rng(base_seed + i); % Set seed for reproducibility and variability
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
    simulate_single_train_run(damage_factors(i), base_seed + i); % Pass seed to simulation
end

fprintf('All %d damage simulations completed.\n', num_cases);
