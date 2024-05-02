clear; clc;

addpath(genpath('simulation'));
addpath(genpath('plot'));
addpath(genpath('func'));

load_path = 'property/';
addpath(load_path);

load_weather_profile = load("load_weather_profiles.mat").samples;

fs = 100;
%%
sample_num = 1;
jan_data = load_weather_profile(1);
date = jan_data.time(sample_num);
load_factor = jan_data.load(sample_num);
T = jan_data.weather(sample_num);

%%
N = 10;
is_damage_local = false;
damage_factor = 1;

% configure train
Train = configure_train('AVE_S103_ICE3', load_path, load_factor);
train_init_velocity = Train.vel;
train_load = Train.TotalVariableMass;

% ---- Track ----
A02_Track;

% ---- Bridge ----
Beam = configure_bridge(T);

ET = Beam.Prop.E;

% ---- Options ----
A04_Options;

Calc.Solver.max_accurate_frq = fs;

%%
% -- Model geometry --
[Calc,Train,Beam] = B43_ModelGeometry(Calc,Train,Track,Beam);

% -- Options Processing --
[Calc,Train,Track,Beam] = B07_OptionsProcessing(Calc,Train,Track,Beam);

% Elements and coordinates
[Beam] = B01_ElementsAndCoordinates(Beam,Calc);

if damage_factor < 1
    % Add effect of damage
    [Beam] = insert_damage(Beam, damage_factor, 2, is_damage_local);
end

%%
[Sol, Model, Calc, Train, Track, Beam] = run_simulation(Train, Track, Beam, Calc);


%%
C02_TimeHistoryPlot(Model,Sol,Beam,Calc);


%% Write out solution
file_name = 'healthy.csv';
if damage_factor ~= 1
    file_name = 'faulty.csv';
end
write_result(Sol, N, file_name, ...
    damage_factor, T, train_init_velocity, ...
    train_load, ET, sample_number, date, fs);
