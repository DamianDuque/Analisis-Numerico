function root = newfalsepos2(func, a, b, tol, max_iter)
    % Inputs:
    %   func: the function for which the root is sought
    %   a, b: initial interval [a, b]
    %   tol: tolerance for stopping criterion
    %   max_iter: maximum number of iterations
    
    % Check if the sign of the function at the endpoints is the same
    if func(a) * func(b) > 0
        error('The function values at the interval endpoints must have different signs.');
    end
    
    % Initialize variables
    iter = 0;
    c = a;  % Initial guess for the root
    
    % Initialize a table for logging iteration information
    iteration_table = table();
    
    % Main loop
    while (b - a) / 2 > tol && iter < max_iter
        % Compute the false position
        c = (a * func(b) - b * func(a)) / (func(b) - func(a));
        
        % Log iteration information
        iteration_table = [iteration_table; table(iter, c, func(c), 'VariableNames', {'Iteration', 'Root', 'FunctionValue'})];
        
        % Check if the root is found
        if func(c) == 0
            break;
        end
        
        % Update the interval [a, b]
        if func(c) * func(a) < 0
            b = c;
        else
            a = c;
        end
        
        % Update the iteration counter
        iter = iter + 1;
    end
    
    % Display results
    fprintf('False Position Method:\n');
    fprintf('Root: %f\n', c);
    fprintf('Function value at the root: %f\n', func(c));
    fprintf('Number of iterations: %d\n', iter);
    
    % Display the iteration table
    disp(iteration_table);

    % Return the root
    root = c;
end

% Define the function
func = @(x) x^3 - 6*x^2 + 11*x - 6.1;

% Initial interval [a, b]
a = 3;
b = 4;

% Tolerance and maximum number of iterations
tol = 1e-6;
max_iter = 100;

% Call the false_position_method function
root = newfalsepos2(func, a, b, tol, max_iter);