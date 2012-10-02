function res = get_matrix_line(current_trial_number, matrix_a, matrix_b)
    % First we need to determine in which matrix we should be
    % taking the line from
    % In the case of AABB, we take twice from A then twice from B, rinse
    % and repeat
    if mod(mod(current_trial_number, 4), 3) ~= 0
        % We should be taking the line from matrix_a
        line_number = floor(current_trial_number / 2) + 1;
        res = matrix_a(line_number, :);        
    else
        % We should be taking the line from matrix_b
        line_number = floor(current_trial_number / 2);
        res = matrix_b(line_number, :);
    end
end