            %Definir x0:
            x0 = [str2num(app.SORmx01.Value);str2num(app.SORmx02.Value);str2num(app.SORmx03.Value)];

            %Definir A:
            A = [str2num(app.SORmA11.Value) str2num(app.SORmA12.Value) str2num(app.SORmA13.Value);str2num(app.SORmA21.Value) str2num(app.SORmA22.Value) str2num(app.SORmA23.Value); str2num(app.SORmA31.Value) str2num(app.SORmA32.Value) str2num(app.SORmA33.Value)];
            
            %Definir B:
            b = [str2num(app.SORmb1.Value);str2num(app.SORmb2.Value);str2num(app.SORmb3.Value)];
            
            %Definir el resto de valores
            Tol = app.SORtol.Value;  %0.05;%app.SORtol.Value;
            niter = app.SORnitter.Value;    %100;%app.SORnitter.Value;
            w = app.SORw.Value;    %1;%app.SORw.Value;
            
            
            
            
            c = 0;
            n = 1;
            error = Tol + 1;

            D = diag(diag(A));
            L = -tril(A, -1);
            U = -triu(A, +1);

            % Inicializar arrays para almacenar los valores
            iteraciones = zeros(1, niter);
            x1_vals = zeros(niter, numel(x0));
            error_vals = zeros(1, niter);

            while error > Tol && c < niter
                T = inv(D - w * L) * ((1 - w) * D + w * U);
                C = w * inv(D - w * L) * b;
                x1 = T * x0 + C;

                % Calcular el error relativo
                E = norm((x1 - x0) ./ x1, 'inf');

                % Almacenar los valores en los arrays
                iteraciones(c + 1) = n;
                x1_vals(c + 1, :) = x1';
                error_vals(c + 1) = E;

                error = E;
                x0 = x1;
                c = c + 1;

                n = n + 1;
            end

            % Redimensionar los arrays para eliminar los elementos no utilizados
            iteraciones = iteraciones(1:c);
            x1_vals = x1_vals(1:c, :);
            error_vals = error_vals(1:c);
            
            % Crear la tabla utilizando array2table y establecer nombres de variables
            tabla = array2table([iteraciones', x1_vals, error_vals'], 'VariableNames', ...
                [{'n'}, strcat('x', arrayfun(@num2str, 1:numel(x0), 'UniformOutput', false)), 'Error']);
            
           

            if error < Tol
                s = x0;
                fprintf('Es una aproximación de la solución del sistema con una tolerancia = %f\n', Tol);
                app.SORTabla.Data = tabla;
                app.SORsolucion.Value = string(s);
                app.SORradioe.Value = num2str(max(abs(eig(A))));
            else
                s = x0;
                app.SORTabla.Data = tabla;
                result = {'Fracasó en ', num2str(niter), ' iteraciones'};
                app.SORsolucion.Value = strcat(result);
                app.SORradioe.Value = num2str(max(abs(eig(A))));
            end