% Spline

%Spline: Calcula los coeficienetes de los polinomios de interpolación de
% grado d (1, 2, 3) para el conjunto de n datos (x,y), 
% mediante el método spline.
function [Tabla] = Spline(x,y,d)
    n=length(x);
    A=zeros((d+1)*(n-1));
    b=zeros((d+1)*(n-1),1);
    cua=x.^2;
    cub=x.^3;
    
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

    val=inv(A)*b;
    Tabla=reshape(val,d+1,n-1);
    Tabla=Tabla';
end

% Graficas

clc 
close all

xpol0=1:0.001:2;
%Cambiarlos por las x que me dan.
xpol1=2:0.001:3;
%xpol2=2:0.001:3;

% p0=2*xpol0+28;
% p1=4*xpol1+24;
% p2=1*xpol2+33;

% p0=Tabla(1,1)*xpol0.^3+Tabla(1,2)*xpol0.^2+Tabla(1,3)*xpol0+Tabla(1,4);
% p1=Tabla(2,1)*xpol1.^3+Tabla(2,2)*xpol1.^2+Tabla(2,3)*xpol1+Tabla(2,4);
% p2=Tabla(3,1)*xpol2.^3+Tabla(3,2)*xpol2.^2+Tabla(3,3)*xpol2+Tabla(3,4);

p0=Tabla(1,1)*xpol0.^2+Tabla(1,2)*xpol0+Tabla(1,3);
p1=Tabla(2,1)*xpol1.^2+Tabla(2,2)*xpol1+Tabla(2,3);
%p2=Tabla(3,1)*xpol2.^2+Tabla(3,2)*xpol2+Tabla(3,3);

plot(x,y,'r*')
hold on
grid on
plot(xpol0,p0,'b',xpol1,p1,'g')%,xpol2,p2,'m'