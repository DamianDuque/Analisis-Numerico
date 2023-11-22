 


            s1 = app.VANDERListBox.Value;
            s2 = 'Cuadrático';
            s3 = 'Cúbico';
            valmet = strcmp(s1,s2);
            valmet2 = strcmp(s1,s3);
            if valmet
                met = 2;
            elseif valmet2
                met = 3;
            else
                met = 1;
            end



            if met == 1
                x=[app.VANDERx1.Value app.VANDERx0.Value]'; %3 3.7 4.4
                y=[app.VANDERy1.Value app.VANDERy0.Value]'; %6 10 15
                
                A=[x ones(2,1)]%x.^3 x.^3
                b=y;
                a=inv(A)*b
                
                xpol=1:0.01:5;
                p=a(1)*xpol+a(2);%a(1)*xpol.^3+
                
                %plot(x,y,'r*',xpol,p,'b-')
                plot(app.VANDERAxes,x,y,'r*',xpol,p,'b-')

            elseif met == 2
                x=[app.VANDERx2.Value app.VANDERx1.Value app.VANDERx0.Value]'; %3 3.7 4.4
                y=[app.VANDERy2.Value app.VANDERy1.Value app.VANDERy0.Value]'; %6 10 15
                
                A=[x.^2 x ones(3,1)]%x.^3 x.^3
                b=y;
                a=inv(A)*b
                
                xpol=1:0.01:5;
                p=a(1)*xpol.^2+a(2)*xpol+a(3);%a(1)*xpol.^3+
                
                %plot(x,y,'r*',xpol,p,'b-')
                plot(app.VANDERAxes,x,y,'r*',xpol,p,'b-')
            
            elseif met == 3
                x=[app.VANDERx3.Value app.VANDERx2.Value app.VANDERx1.Value app.VANDERx0.Value]'; %3 3.7 4.4
                y=[app.VANDERy3.Value app.VANDERy2.Value app.VANDERy1.Value app.VANDERy0.Value]'; %6 10 15
                
                A=[x.^3 x.^2 x ones(4,1)]%x.^3 x.^3
                b=y;
                a=inv(A)*b
                
                xpol=1:0.01:5;
                p=a(1)*xpol.^3+a(2)*xpol.^2+a(3)*xpol+a(4);%a(1)*xpol.^3+
                
                plot(app.VANDERAxes,x,y,'r*',xpol,p,'b-')
            end