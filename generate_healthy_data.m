% Script to generate 200 healthy samples for a train infrastructure simulation
%

% Constants for the simulation
damage_factor = 1.0;  % Assuming damage factor of 1 implies a healthy condition
num_samples = 200;    % Number of healthy samples to generate

% Optional: Set up a seed for reproducibility
seed = 42; % You can change this for each iteration if variability is desired

% Loop to generate samples
for i = 1:num_samples
    fprintf('Running simulation %d of %d...\n', i, num_samples);
    simulate_single_train_run(damage_factor, seed);
    % Optionally increment seed if different randomness is required per run
    seed = seed + 1; % Uncomment this line to change seed per iteration
end

fprintf('All %d healthy simulations completed.\n', num_samples);