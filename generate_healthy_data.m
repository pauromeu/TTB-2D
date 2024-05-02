% Script to generate 200 healthy samples for a train infrastructure simulation

clear; clc;

addpath(genpath('simulation'));
addpath(genpath('plot'));
addpath(genpath('func'));

load_path = 'property/';
addpath(load_path);

% Constants for the simulation
damage_factor = 1;  % Assuming damage factor of 1 implies a healthy condition
is_damage_local = false;
max_frq = 1000;
file_name = 'healthy_2023.csv';

%%
load_weather_profile = load("load_weather_profiles.mat").samples;


%%

for mi = 1:12
    month_data = load_weather_profile(mi);
    m_length = size(month_data.time, 1);
    
    % Loop to generate samples
    for j = 1:m_length
        sample_number = (mi-1) * m_length + j;
        fprintf('Running simulation of month %d, sample number %d...\n', mi, sample_number);
        load_factor_j = month_data.load(j);
        T_j = month_data.weather(j);
        date_j = month_data.time(j);
        simulate_single_train_run(damage_factor, T_j, load_factor_j, ...
            sample_number, is_damage_local, max_frq, date_j, file_name);
        sample_number = sample_number + 1;
    end
end


fprintf('All %d healthy simulations completed.\n', sample_number);