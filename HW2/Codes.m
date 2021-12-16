clc
clear all
close all
disp('-------------------------------------1f-----------------------------')
syms N1(x) N2(x) N3(x) N4(x) x Le EI qo

s=x/Le;
N1(x)=1- 3*s^2 + 2*s^3;
N2(x)=Le*(s - 2*s^2 + s^3);
N3(x)=3*s^2 - 2*s^3;
N4(x)=Le*(-s^2 + s^3);

N=[N1(x),N2(x),N3(x),N4(x)];
B=diff(N,2)

Ke=int(EI*B'*B,0,Le)

disp('-------------------------------------1g-----------------------------')
Pfef=int(qo*N,0,Le)
