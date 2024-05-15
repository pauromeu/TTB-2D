clear; clc; restoredefaultpath;

addpath(genpath('simulation'));
addpath(genpath('plot'));
addpath(genpath('functions'));

seed = 42;
rng(seed);

% Define the parameters for the simulation

VehicleArgs = struct();
VehicleArgs.train_name = 'AVE_S103_ICE3';
VehicleArgs.velocity_m_s = 150/3.6;
VehicleArgs.load_base_kg = 5000.0;
VehicleArgs.load_factor = 0.5;
VehicleArgs.load_std = 0.0;

BridgeArgs = struct();
BridgeArgs.damage_factor = 0.7;
BridgeArgs.damage_center_location = 0.2;
BridgeArgs.damage_num_elements = 2;
BridgeArgs.damage_local = true;
BridgeArgs.num_sensors = 10;
BridgeArgs.elastic_module_randomness = false;

EnvironmentArgs = struct();
EnvironmentArgs.temperature_C = 20.0;

SimulationArgs = struct();
SimulationArgs.freq = 1000;

FileArgs = struct();
FileArgs.file_name = 'comparative.csv';
FileArgs.date = datetime('now');
FileArgs.sample_number = -1; % -1 for automatic numbering

damage_factors = 0.6:0.1:1.0;

for i = 1:length(damage_factors)
    BridgeArgs.damage_factor = damage_factors(i);
    simulate_single_pass(VehicleArgs, BridgeArgs, EnvironmentArgs, SimulationArgs, FileArgs);
end