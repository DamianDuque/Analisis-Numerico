xtemp = app.LAGx.Value;
            ytemp = app.LAGy.Value;
            disp(xtemp);
            disp(ytemp);
            x = str2double(strsplit(xtemp));
            y = str2double(strsplit(ytemp));
            disp(x);
            disp(y);
            if numel(x)~=numel(unique(x))
                disp('oh no, we have duplicates!')
            end
        
            n = length(x);
            Tabla = zeros(n, n);
        
            % Itera sobre cada punto de datos
            for i = 1:n
                Li = 1;
                den = 1;
        
                % Itera sobre cada punto de datos nuevamente para construir el polinomio de Lagrange
                for j = 1:n
                    if j ~= i
                        paux = [1, -x(j)];
                        Li = conv(Li, paux);
                        den = den * (x(i) - x(j));
                    end
                end
        
                % Almacena los coeficientes correspondientes al i-ésimo punto en la tabla
                Tabla(i, :) = y(i) * Li / den;
            end
        
            % Suma los coeficientes para obtener el polinomio de interpolación
            pol = sum(Tabla);
        
            % Grafica los puntos de datos

        
            % Genera puntos para la curva del polinomio
            x_interp = linspace(min(x), max(x), 1000);
            y_interp = polyval(pol, x_interp);
        
            % Grafica la curva del polinomio de interpolación
            hold(app.LAGAxes, 'on');
            scatter(app.LAGAxes,x, y, 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
            plot(app.LAGAxes,x_interp, y_interp, 'r', 'LineWidth', 2);
            
        
            % Configura el título y etiquetas del gráfico
            title(app.LAGAxes,'Polinomio de Interpolación de Lagrange');