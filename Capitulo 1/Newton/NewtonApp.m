cla(app.NEWAxes, 'reset');
            func = app.NEWFunc.Value;
            func2 = str2func(['@(x)',func]);
            x0 = str2double(app.NEWFuncx0.Value);

            syms x
            
            f = func2;

            Tol = str2double(app.NEWTol.Value);
            niter = str2double(app.NEWNitter.Value);
            
            % Newton: se ingresa el valor inicial (x0), la tolerancia del error (Tol) y el máximo número de iteraciones (niter)

        %function [n, xn, fm, dfm, E, D] = newtonfinal(x0, Tol, niter)
            syms x
        
            %f = (x^4) - 7*(x^3) + 16*(x^2) - 12*x;
            df = diff(f, x);
            c = 0;
            N(c+1) = c;
            fm(c+1) = eval(subs(f, x0));
            fe = fm(c+1);
            dfm(c+1) = eval(subs(df, x0));
            dfe = dfm(c+1);
            E(c+1) = Tol + 1;
            error = E(c+1);
            xn(c+1) = x0;
        
            while error > Tol && c < niter
                xn(c+2) = x0 - fe/dfe;
                fm(c+2) = eval(subs(f, xn(c+2)));
                fe = fm(c+2);
                dfm(c+2) = eval(subs(df, xn(c+2)));
                dfe = dfm(c+2);
                E(c+2) = abs(xn(c+2) - x0);
                error = E(c+2);
                x0 = xn(c+2);
                N(c+2) = c+1;
                c = c+1;
            end
        
            if fe == 0
               s = x0;
               n = c;
               fprintf('%f es raíz de f(x) \n', x0);
            elseif error <= Tol
               s = x0;
               n = c;
               fprintf('%f es una aproximación de una raíz de f(x) con una tolerancia= %f \n', x0, Tol);
            elseif dfe == 0
               s = x0;
               n = c;
               fprintf('%f es una posible raíz múltiple de f(x) \n', x0);
            else 
               s = x0;
               n = c;
               fprintf('Fracasó en %d iteraciones \n', niter);
            end
        
            % Mostrar la tabla
            
            D = table(N', xn', fm', E');
            fplot(app.NEWAxes,func2, 'b')
            app.NEWTabla.Data = D;
            disp(D);