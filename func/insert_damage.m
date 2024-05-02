function Beam = insert_damage(Beam, damage_factor, n, local)
    % Reduces the middle n values of the Beam.Prop.E_n array by 10%.
    %
    % Input:
    %   Beam - A structure that contains the array Beam.Prop.E_n
    %   n - The number of middle values to be reduced
    %
    % Output:
    %   Beam - The updated structure with modified Beam.Prop.E_n
    
    % Find the total number of elements in the array
    N = numel(Beam.Prop.E_n);
    
    if local
        % Calculate the starting and ending indices for the middle n values
        middle_start = ceil((N - n) / 2) + 1;
        middle_end = middle_start + n - 1;
    
        % Ensure the indices do not exceed the array bounds
        middle_start = max(middle_start, 1);
        middle_end = min(middle_end, N);
    

    else
        middle_start = 1;
        middle_end = N;
    end

    % Reduce the middle n values by damage_factor
    Beam.Prop.E_n(middle_start:middle_end) = Beam.Prop.E_n(middle_start:middle_end) * damage_factor;

end
