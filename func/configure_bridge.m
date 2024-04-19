function Beam = configure_bridge(T)

% A 50m bridge. Properties taken from:
% He Xia, Nan Zhang, Guido De Roeck, Dynamic analysis of high speed railway 
%   bridge under articulated trains, Computers & Structures, Volume 81, 
%   Issues 26–27, 2003, Pages 2467-2478, ISSN 0045-7949,
%   https://doi.org/10.1016/S0045-7949(03)00309-2.
Beam.Prop.L = 50;       % Span [m]
Beam.Prop.E = 35e9;     % Modulus of elasticity [N/m^2]
Beam.Prop.I = 51.3;     % Second moment of area [m4]
Beam.Damping.per = 1;   % Damping [%]
Beam.Prop.rho = 69000;  % Mass per unit length [kg/m]

% Boundary conditions
Beam.BC.text = 'SP';    % Simply supported
% Beam.BC.text = 'FF';    % Fixed-fixed

% Modify stiffness by temperature
Beam.Prop.E = get_stiffness_by_temp(Beam.Prop.E, T);


end

