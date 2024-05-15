function Train = set_train(train_args)
% SET_TRAIN Function to set up train configurations dynamically
% Input:
%  train_args - A struct containing the following fields:
%   train_name - A string specifying the type of train configuration.
%   velocity_m_s - The velocity of the train in m/s
%   load_base_kg - The base load of the train in kg
%   load_factor - The load factor of the train as times the base load
% Output:
%   Train - A struct containing the train configuration

velocity_m_s = train_args.velocity_m_s;
load_base_kg = train_args.load_base_kg;
load_factor = train_args.load_factor;
load_std = train_args.load_std;
train_name = train_args.train_name;

Train.vel = velocity_m_s;
Train.Load.path = 'property/';
load_vehicle_mean = load_base_kg * (1 + load_factor);

switch train_name
    case 'AVE_S103_ICE3'
        config_files = {'TrainProp_AVE_S103_ICE3_Velaro_E_C1', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C45', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C45', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
            'TrainProp_AVE_S103_ICE3_Velaro_E_C8'};
        % total_mass = 0;
        for veh_num = 1:length(config_files)
            run(fullfile(Train.Load.path, config_files{veh_num}));
            Train.Veh(veh_num).vel = Train.vel;
            
            vehicle_mass = normrnd(load_vehicle_mean, load_std);
            % total_mass = total_mass + vehicle_mass;
            Train.Veh(veh_num).Body.m = vehicle_mass;
        end
        % Train.TotalVariableMass = total_mass - load_base_kg * veh_num;
        
    otherwise
        error('Unsupported train configuration option: %s', option);
end

