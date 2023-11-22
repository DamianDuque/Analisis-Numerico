            cla(app.BiAxes, 'reset');
            func = app.BiFunc.Value;
            func2 = str2func(['@(x)',func]);
            xi = str2double(app.BiFuncx1.Value);
            xs = str2double(app.BiFuncx2.Value);
            syms x
            fprintf('xi: %f\n', xi);
            fprintf('xs: %f\n', xs);
            resxi = xi;
            resxs = xs;

            f = func2;

            Tol = str2double(app.BiTol.Value);
            niter = str2double(app.BiNitter.Value);
        
            fi = f(xi);
            fs = f(xs);
        
            tabla = table(NaN, NaN, NaN, 'VariableNames', {'Iteracion', 'E', 'f(x)'});
            c = 0;
            
            if fi == 0
                tabla = table(0, NaN, NaN, 'VariableNames', {'Iteracion', 'E', 'f(x)'});
                fprintf('%f es raíz de f(x)\n', xi);
                %plotFunc(xi, xs);
                return;
            elseif fs == 0
                tabla = table(0, NaN, NaN, 'VariableNames', {'Iteracion', 'E', 'f(x)'});
                fprintf('%f es raíz de f(x)\n', xs);
                %plotFunc(xi, xs);
                return;
            elseif fs * fi < 0
                xm = (xi + xs) / 2;
                fm = eval(subs(f, xm));
                fe = fm;
                E = Tol + 1;
                error = E;
                tabla(end, :) = table(c, E, fm, 'VariableNames', {'Iteracion', 'E', 'f(x)'});
        
                while error > Tol && fe ~= 0 && c < niter
                    if fi * fe < 0
                        xs = xm;
                        fs = eval(subs(f, xs));
                    else
                        xi = xm;
                        fi = eval(subs(f, xi));
                    end
                    xa = xm;
                    xm = (xi + xs) / 2;
                    fm = eval(subs(f, xm));
                    fe = fm;
                    E = abs(xm - xa);
                    error = E;
                    c = c + 1;
        
                    tabla(end + 1, :) = table(c, E, fm, 'VariableNames', {'Iteracion', 'E', 'f(x)'});
                end
        
                if fe == 0
                    fprintf('%f es raíz de f(x)\n', xm);
                elseif error < Tol
                    fprintf('%f es una aproximación de una raíz de f(x) con una tolerancia = %f\n', xm, Tol);

                else
                    fprintf('Fracasó en %d iteraciones\n', niter);
                end
                
                %plotFunc(xi, xs);
            else
                fprintf('El intervalo es inadecuado\n');
                tabla = [];
            end

            
            %function [] = plotFunc(xi, xs);
                %f = @(x) x.^2 - 5*x + 6*sin(x);
                fplot(app.BiAxes,func2, [resxi resxs], 'b')
                app.BiTabla.Data = tabla;