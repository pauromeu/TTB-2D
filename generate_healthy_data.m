% Script to generate 200 healthy samples for a train infrastructure simulation
% Note that we generate continous damage factor values between 0.7 and 1.0, whereas in the original PTAE paper, the damage factor is discretized into 3 levels: 0.9, 0.8 and 0.7.


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