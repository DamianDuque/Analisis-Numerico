%function T = secante3(x0, x1, Tol, TypeTol, niter)
            
            cla(app.SECAxes, 'reset');
            func = app.SECFunc.Value;
            func2 = str2func(['@(x)',func]);
            x0 = str2double(app.SECFuncx0.Value);
            x1 = str2double(app.SECFuncx1.Value);
            
            syms x
        

            f = func2;%exp(-x)*(-1 + x) + (x^(2/3)) - 65;
            Tol = str2double(app.SECTol.Value);
            niter = str2double(app.SECNitter.Value);
            TypeTol = 0;

    

            % Inicializamos arreglos con el máximo número de iteraciones
            N = zeros(1, niter+2);
            XN = zeros(1, niter+2);
            fm = zeros(1, niter+2);
            E = zeros(1, niter+2);
            K = zeros(1, niter+2);
            
            % Inicializamos el contador
            c = 0;
            
            % Encontramos f(x0) y lo guardamos en el arreglo de fm
            fm(c+1) = eval(subs(f, x0));
            f0 = fm(c+1);
            
            % Encontramos f(x1) y lo guardamos en el arreglo de fm
            fm(c+2) = eval(subs(f, x1));
            fe = fm(c+2);
            
            % Guardamos los errores de x0 y x1
            E(c+1) = Tol + 1;
            E(c+2) = Tol + 1;
            error = E(c+2);
            K(c+1) = E(c+2)/(E(c+1)^1.62);
            
            % Guardo en xn mi última x, que en este caso es x1
            xn = x1;
            
            % Guardamos en un arreglo las iteraciones que llevamos
            N(c+1) = c;
            N(c+2) = c;
            
            % Guardamos la x en un arreglo de XN
            XN(c+1) = x0;
            XN(c+2) = xn;
        
            % Iteramos hasta que lleguemos a la solución o se llegue a la
            % tolerancia o al máximo de iteraciones
            while error > Tol && fe ~= 0 && c < niter
                % Hallamos nuestra xm y la guardamos en el arreglo de XN
                xm = xn - ((fe * (xn - x0)) / (fe - f0));
                XN(c+3) = xm;
        
                % Guardamos nuestro fe anterior y hallamos el nuevo f(xm)
                f0 = fe;
                fm(c+3) = eval(subs(f, xm));
                fe = fm(c+3);
        
                % Hallamos el error según lo que nos pidan (decimales correctos o cifras significativas)
                if TypeTol == 0
                    E(c+3) = abs(xm - xn);
                else
                    E(c+3) = abs((xm - xn) / xm);
                end
        
                K(c+2) = E(c+3) / (error^1.62);
                error = E(c+3);
        
                % Hacemos el intercambio de las x
                x0 = xn;
                xn = xm;
        
                % Guardamos la iteración y avanzamos
                N(c+3) = c+1;
                c = c+1;
            end
        
            if fe == 0
                fprintf('%f es raiz de f(x) \n', xn);
            elseif error <= Tol
                fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f \n', xn, Tol);
            else
                fprintf('Fracasó en %d iteraciones \n', niter);
            end
        
            % Reducir los arreglos a la longitud correcta
            N = N(1:c+2);
            XN = XN(1:c+2);
            fm = fm(1:c+2);
            E = E(1:c+2);
            K = K(1:c+2);
        
            % Mostrar la tabla
            T = table(N', XN', fm', E', K', 'VariableNames', ["n", "Xn", "Fm", "Error", "K"]);
            
            % Graficar
            xplot = ((xn-2):0.1:(xn+2));
            %hold on
            plot(app.SECAxes,xplot, eval(subs(f, xplot)));
            %hold off

            %Mostrar tabla en appdesigner
            app.SECTabla.Data = T;