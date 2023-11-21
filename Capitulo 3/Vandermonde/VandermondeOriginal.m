clc
clear all
close all

x=[0 4 3 1]'; %3 3.7 4.4
y=[0 5 5 4]'; %6 10 15

A=[x.^3 x.^2 x ones(4,1)]%x.^3 x.^3
b=y;
a=inv(A)*b

xpol=1:0.01:5;
p=a(1)*xpol.^3+a(2)*xpol.^2+a(3)*xpol+a(4);%a(1)*xpol.^3+

plot(x,y,'r*',xpol,p,'b-')
hold on
grid on