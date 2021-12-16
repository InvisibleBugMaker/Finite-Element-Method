% PRISMATIC SECTION

A=@(x) A0*(1-(x/L)^2)+A1*(x/L)^2;   %m^2
% ^ this function is NOT CORRECT as our section is NOT PRISMATIC
% Modify this to reflect the true area of the section as a function of x
%e.g. A=@(x) some function of x which represents area as a function of x

%Obtaining the undeformed cross sectional area of the center of the
%current element
ElA=A(currentElemCenterXloc);
