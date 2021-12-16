%Code for homogeneous, isotropic, elastic analysis of 2D solids. 
%It can run both plane stress and plane strain. 
%This code could be made to work for inhomogeneous materials if each
%element could have different material properties, but still only isotropic
%is allowed in this formulation.

%--------------------------------------------------------------------------
%Stage 1 Preprocessing/Input Section
%Commercial software can create the n_info, e_info, l_info from a CAD file
%instead. The e_info & n_info creation is often called "Meshing"

%Material Properties
E=29000;
nu=0.3;

%Define P-stress or P-strain
type=0;   %0 = Plane Stress,  1 = Plane Strain

%Nodal Information Matrix
%dx and dy below are support settlement, only used if fixed.
%      [x y fx fy dx dy], 1 = fixed, 0 = free
n_info=[0 0      1 1 0 0;
        0   -10  1 1 0 0;
        5   -10  0 0 0 0;
        7.5 -7.5 0 0 0 0;
        10  -5   0 0 0 0;
        10   0   1 1 0 0];
    

%Element Information Matrix
%      [i j k]
e_info=[1 2 3;
        1 3 4;
        1 4 5;
        1 5 6];
    
%Load Information Matrix. Note the load is per unit width
%       [node px py]
l_info=[3 50/sqrt(2)/(5/8)  -50/sqrt(2)/(5/8);
        4 100/sqrt(2)/(5/8) -100/sqrt(2)/(5/8);
        5 50/sqrt(2)/(5/8)  -50/sqrt(2)/(5/8)];

%End Input Section
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%Stage 2 Processing/Analysis/Solving, get nodal  & Reactions
solver

%Stage 3 Postprocessing, plot def, stresses, etc
plotter
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++