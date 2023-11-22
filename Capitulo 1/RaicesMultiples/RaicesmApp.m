cla(app.RMAxes, 'reset');
            func = app.RMFunc.Value;
            func2 = str2func(['@(x)',func]);
            x0 = str2double(app.RMFuncx0.Value);

            syms x
            
            f = str2sym(func);

            Tol = str2double(app.RMTol.Value);
            niter = str2double(app.RMNitter.Value);





            %Newton: se ingresa el valor inicial (x0), la tolerancia del error (Tol) y el màximo nùmero de iteraciones (niter) 

    %function [n,xn,fm,dfm,E] = newtonM2(x0,Tol,niter)
            syms x
    
            %f=x^4-7*x^3+16*x^2-12*x;
            df=diff(f, x);
            ddf=diff(f,2);
            c=0;
            N(c+1)=c;
            fm(c+1) = eval(subs(f,x0));
            fe=fm(c+1);
            dfm(c+1) = eval(subs(df,x0));
            dfe=dfm(c+1);
            ddfm(c+1) = eval(subs(ddf,x0));
            ddfe=ddfm(c+1);
            E(c+1)=Tol+1;
            error=E(c+1);
            xn(c+1)=x0;
            while error>Tol 
                xn(c+2)=x0-(fe*dfe)/((dfe^2)-fe*ddfe);
                fm(c+2)=eval(subs(f,xn(c+2)));
                fe=fm(c+2);
                dfm(c+2)=eval(subs(df,xn(c+2)));
                dfe=dfm(c+2);
                ddfm(c+2) = eval(subs(ddf,xn(c+2)));
                ddfe=ddfm(c+2);
                E(c+2)=abs(xn(c+2)-x0);
                error=E(c+2);
                x0=xn(c+2);
                N(c+2)=c+1;
                c=c+1;
            end
            if fe==0
               s=x0;
               n=c;
               fprintf('%f es raiz de f(x) \n',x0)
               disp(['      n                Xn                   Fx                   Error'])
               D=[N' xn' fm' E'];
               disp(D)
    
            elseif error<Tol
               s=x0;
               n=c;
               %fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f \n',x0,Tol)
               disp(['      n                Xn                   Fx                   Error'])
               D=[N' xn' fm' E'];
               disp(D)
            elseif dfe==0
               s=x0;
               n=c;
               fprintf('%f es una posible raiz múltiple de f(x) \n',x0)
            elseif ddfe==0
               s=x0;
               n=c;
               fprintf('%f es una posible raiz múltiple de f(x) \n',x0)
            else 
               s=x0;
               n=c;
               fprintf('Fracasó en %f iteraciones con %f \n',niter,x0) 
            end

            
            fplot(app.RMAxes,func2, 'b')
            app.RMTabla.Data = D;
            %disp(D);