%SOR: Calcula la solución del sistema
%Ax=b con base en una condición inicial x0,mediante el método Gauss Seidel (relajado), depende del valor de w 
%entre (0,2)

function [s] = SOR(x0,A,b,Tol,niter,w)
    c=0;
    n=1;
    error=Tol+1;
    D=diag(diag(A));
    L=-tril(A,-1);
    U=-triu(A,+1);
    fprintf('|--------------------------------------------------------------------------|\n');
    fprintf('|              |                      xi                    |              |\n');
    fprintf('|      n       |--------------------------------------------|       E      |\n');
    fprintf('|              |      x1      |      x2      |      x3      |              |\n');
    fprintf('|--------------------------------------------------------------------------|\n');
    while error>Tol && c<niter

        T=inv(D-w*L)*((1-w)*D+w*U);
        C=w*inv(D-w*L)*b;
        x1=T*x0+C;
        %E(c+1)=norm(x1-x0,'inf'); % Error absoluto
        E(c+1)=norm((x1-x0)./x1,'inf'); %Error relativo
        error=E(c+1);
        x0=x1;
        c=c+1;

        fprintf('|  %10.2f  ', n);
        fprintf('|  %10.4f  ', x1);
        fprintf('|  %10.5f  ', error);
        fprintf('|\n');
        fprintf('|--------------------------------------------------------------------------|\n');

        n=n+1;
    end
    if error < Tol
        s=x0;
        n=c;
        s
        fprintf('es una aproximación de la solución del sistmea con una tolerancia= %f',Tol)
    else 
        s=x0;
        n=c;
        fprintf('Fracasó en %f iteraciones',niter) 
    end
end