function result = sample_solution(U, n)
    % Extracts the middle values from the matrix Sol.Beam.U by dividing it
    % into n equally (as possible) sized pieces and selecting the middle value from each piece.
    % Inputs:
    %   U - Solution array of size [N, T]
    %   n - The number of pieces to divide the matrix into
    % Outputs:
    %   result - A [n, T] matrix containing the middle values from each piece

    % Retrieve the matrix from the structure
    [N, ~] = size(U);

    l = ceil(N / n);

    % Determine the starting index, which is roughly n/2
    start_index = ceil(l / 2);

    % Calculate the indices to extract: start at start_index, step by n, up to N
    indices = start_index:l:N;
    
    % Extract rows at these indices
    result = U(indices, :);
    
    % Return the result
    return;
end
