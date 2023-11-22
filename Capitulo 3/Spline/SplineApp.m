            s1 = app.SPLINEListBox.Value;
            s2 = 'Cuadrático';
            s3 = 'Cúbico';
            valmet = strcmp(s1,s2);
            valmet2 = strcmp(s1,s3);
            if valmet
                d = 2;
            elseif valmet2
                d = 3;
            else
                d = 1;
            end
            
            
            xtemp = app.SPLINEx.Value;
            ytemp = app.SPLINEy.Value;
            disp(xtemp);
            disp(ytemp);
            x = str2double(strsplit(xtemp));
            y = str2double(strsplit(ytemp));
            disp(x);
            disp(y);
            
            n = length(x);
            A = zeros((d + 1) * (n - 1));
            b = zeros((d + 1) * (n - 1), 1);
            cua = x.^2;
            cub = x.^3;
        
            %% lineal
            if d==1
                c=1;
                h=1;
                for i=1:n-1
                    A(i,c)=x(i);
                    A(i,c+1)=1;
                    b(i)=y(i);
                    c=c+2;
                    h=h+1;
                end
                
                c=1;
                for i=2:n
                    A(h,c)=x(i);
                    A(h,c+1)=1;
                    b(h)=y(i);
                    c=c+2;
                    h=h+1;
                end
            %% Cuadratic
            elseif d==2
                c=1;
                h=1;
                for i=1:n-1
                    A(i,c)=cua(i);
                    A(i,c+1)=x(i);
                    A(i,c+2)=1;
                    b(i)=y(i);
                    c=c+3;
                    h=h+1;
                end
                
                c=1;
                for i=2:n
                    A(h,c)=cua(i);
                    A(h,c+1)=x(i);
                    A(h,c+2)=1;
                    b(h)=y(i);
                    c=c+3;
                    h=h+1;
                end
                
                c=1;
                for i=2:n-1
                    A(h,c)=2*x(i);
                    A(h,c+1)=1;
                    A(h,c+3)=-2*x(i);
                    A(h,c+4)=-1;
                    b(h)=0;
                    c=c+4;
                    h=h+1;
                end
                
                A(h,1)=2;
                b(h)=0;
                
          %% Cubic
            elseif d==3
                c=1;
                h=1;
                for i=1:n-1
                    A(i,c)=cub(i);
                    A(i,c+1)=cua(i);
                    A(i,c+2)=x(i);
                    A(i,c+3)=1;
                    b(i)=y(i);
                    c=c+4;
                    h=h+1;
                end
                
                c=1;
                for i=2:n
                    A(h,c)=cub(i);
                    A(h,c+1)=cua(i);
                    A(h,c+2)=x(i);
                    A(h,c+3)=1;
                    b(h)=y(i);
                    c=c+4;
                    h=h+1;
                end
                
                c=1;
                for i=2:n-1
                    A(h,c)=3*cua(i);
                    A(h,c+1)=2*x(i);
                    A(h,c+2)=1;
                    A(h,c+4)=-3*cua(i);
                    A(h,c+5)=-2*x(i);
                    A(h,c+6)=-1;
                    b(h)=0;
                    c=c+4;
                    h=h+1;
                end
                
                c=1;
                for i=2:n-1
                    A(h,c)=6*x(i);
                    A(h,c+1)=2;
                    A(h,c+4)=-6*x(i);
                    A(h,c+5)=-2;
                    b(h)=0;
                    c=c+4;
                    h=h+1;
                end
                
                A(h,1)=6*x(1);
                A(h,2)=2;
                b(h)=0;
                h=h+1;
                A(h,c)=6*x(end);
                A(h,c+1)=2;
                b(h)=0;
            end
        
            val = inv(A) * b;
            Tabla2 = reshape(val, d + 1, n - 1);
            Tabla2 = Tabla2';
        
            % Graficar automáticamente
            figure;
            plot(app.SPLINEAxes,x, y, 'r*');
            hold(app.SPLINEAxes,"on");
        
            % Crear xpol para la graficación
            xpol = cell(1, n - 1);
            for i = 1:n - 1
                xpol{i} = linspace(x(i), x(i + 1), 1000);
            end
        
            % Graficar los polinomios
            for i = 1:n - 1
                p = polyval(Tabla2(i, :), xpol{i});
                plot(app.SPLINEAxes,xpol{i}, p);
            end
        
            grid on;
            title(app.SPLINEAxes,['Interpolación Spline de grado ' num2str(d)]);
            app.SPLINETabla.Data = Tabla2;
            % Ajusta según el grado máximo
