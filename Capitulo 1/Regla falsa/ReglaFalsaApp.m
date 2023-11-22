function root = newfalsepos2(func, a, b, tol, max_iter)
                % Inputs:
                %format long
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
                app.RFTabla.Data = iteration_table;
            
                % Return the root
                root = c;
            end

            % Call the false_position_method function
            cla(app.RFAxes, 'reset');
            functval = app.RFFunc.Value;
            func2 = str2func(['@(x)',functval]);
            a = str2double(app.RFFa.Value);
            b = str2double(app.RFFb.Value);
            tol = str2double(app.RFTol.Value);
            max_iter = str2double(app.RFNitter.Value);
            fprintf('tol: %f\n', tol);
            fprintf('max: %f\n', max_iter);

            root = newfalsepos2(func2, a, b, tol, max_iter);
            
            fplot(app.RFAxes,func2, 'b')