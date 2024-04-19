clear; clc;

addpath(genpath('simulation'));
addpath(genpath('func'));

load_path = 'property/';

T = draw_weather_sample("temp", 1);
N = 10;
damage_factor = 0.9;

% configure train
Train = configure_train('AVE_S103_ICE3', load_path);
train_init_velocity = Train.vel;

% ---- Track ----
A02_Track;

% ---- Bridge ----
Beam = configure_bridge(T);

% ---- Options ----
A04_Options;

%%
% -- Model geometry --
[Calc,Train,Beam] = B43_ModelGeometry(Calc,Train,Track,Beam);

% -- Options Processing --
[Calc,Train,Track,Beam] = B07_OptionsProcessing(Calc,Train,Track,Beam);

% Elements and coordinates
[Beam] = B01_ElementsAndCoordinates(Beam,Calc);

%%
% Add effect of damage
[Beam] = insert_damage(Beam, damage_factor, 2);


%%
[Sol, Model, Calc, Train, Track, Beam] = run_simulation(Train, Track, Beam, Calc);


%% Write out solution
file_name = 'healthy.csv';
if damage_factor ~= 1
    file_name = 'faulty.csv';
end
write_result(Sol, N, file_name, damage_factor, T, train_init_velocity, 1);

