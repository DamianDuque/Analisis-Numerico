xtemp = app.NIx.Value;
            ytemp = app.NIy.Value;
            disp(xtemp);
            disp(ytemp);
            x = str2double(strsplit(xtemp));
            y = str2double(strsplit(ytemp));
            disp(x);
            disp(y);
            
            function y = NewtonPolyEval(Tabla, x_eval)
                n = size(Tabla, 1);
                y = Tabla(1, 2);
            
                for i = 2:n
                    term = Tabla(i, i+1);
                    for j = 1:i-1
                        term = term * (x_eval - Tabla(j, 1));
                    end
                    y = y + term;
                end
            end

            
            n = length(x);
            Tabla = zeros(n, n+1);
            Tabla(:, 1) = x;
            Tabla(:, 2) = y;
        
            for j = 3:n+1
                for i = j-1:n
                    Tabla(i, j) = (Tabla(i, j-1) - Tabla(i-1, j-1)) / (Tabla(i, 1) - Tabla(i-j+2, 1));
                end
            end
        
            % Generar puntos para graficar el polinomio interpolante
            x_interp = linspace(min(x), max(x), 1000);
            y_interp = zeros(size(x_interp));
        
            % Evaluar el polinomio interpolante en los puntos interpolados
            for k = 1:length(x_interp)
                y_interp(k) = NewtonPolyEval(Tabla, x_interp(k));
            end
        
            % Graficar los puntos de datos y el polinomio interpolante
            hold(app.NIAxes, 'on')
            plot(app.NIAxes,x_interp, y_interp, 'r-', 'DisplayName', 'Polinomio Interpolante');
            title(app.NIAxes,'Interpolación de Newton');
            scatter(app.NIAxes,x, y, 'o', 'DisplayName', 'Datos');

            app.NITabla.Data = Tabla;