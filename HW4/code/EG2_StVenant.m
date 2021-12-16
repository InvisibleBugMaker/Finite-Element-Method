%This example shows how local effects (e.g., point loads and boundary
%conditions distribute to more uniformly distributed stresses. This
%phenomenon applies in many different scenarios, but this example is a
%point load.

%This example is an upper 1/2 domain model that exploits symmetry.

%This example is clamped on the left, free elsewhere

%This code is clumsy. Tying BCs to n-info is not really great. it would be
%to mesh independent of BCs, then have a separate operation to apply BCs.

%--------------------------------------------------------------------------
%Stage 1 Preprocessing/Input Section
%Commercial software can create the n_info, e_info, l_info from a CAD file
%instead. The e_info & n_info creation is often called "Meshing"

%Material Properties
E=29000;
nu=0.3;
PL=1;     %Point load at single node. Note, this is per unit depth.

%Define P-stress or P-strain
type=0;   %0 = Plane Stress,  1 = Plane Strain

h=1;        %Half Height (half model using symmetry)
b=5;       %Full Span
numh=2;    %Number of elements through depth. Will will automaticall find 
            %number through span to achieve near unit aspect ratio

%**************************************************************************
%CONSTRUCT N_INFO
%Find dx and dy which are the horizontal and vertical lengths of the triangles
dy=h/numh;
%Find dx that creates near unit aspect raio triangles
numb=floor(b/dy);
dx=b/numb;  

%Construct left wall, which is fixed (the stuff below here is a bit ugly)
n_info=zeros(numh+1,1);           %x-coord of left wall
y_coords=linspace(0,h,numh+1)';   %y-coord column of a vertical strip of nodes
n_info=[n_info y_coords];     %append the y-coords
n_info=[n_info ones(numh+1,1) ones(numh+1,1)];   %append fixed in x and y columns
n_info=[n_info zeros(numh+1,2)];  %append the support disps, which are all zero

%Construct the rest of the vertical strips of nodes, each bottom one is
%x-roller
for i=1:numb
  xpos=dx*i;
  n_info_temp=[xpos*ones(numh+1,1) y_coords zeros(numh+1,4)];
  n_info_temp(1,4)=1;  %Make the bottom one restrained in y, i.e.,m an x-roller
  n_info=[n_info;n_info_temp];  %add new row to overall n_info matrix
end

%**************************************************************************
%CONSTRUCT E_INFO
e_info=[0 0 0];  %Initialize, will delete this row at the end
%Walk upward one strip at a time
for i=1:numb
  bl=(i-1)*(numh+1)+1; %Bottom left node of strip
  br=i*(numh+1)+1;
  %Make lower triangles first
  e_info_temp=[linspace(bl,bl+numh-1,numh)' linspace(br,br+numh-1,numh)' linspace(br,br+numh-1,numh)'+1];
  e_info=[e_info;e_info_temp];
  %Then upper triangle
  e_info_temp=[linspace(bl,bl+numh-1,numh)' linspace(bl,bl+numh-1,numh)'+1 linspace(br,br+numh-1,numh)'+1];
  e_info=[e_info;e_info_temp];
end
e_info(1,:)=[];


%**************************************************************************
%CONSTRUCT L_INFO
%Only one load here. On the right-bottom most node.
Load_Node=size(n_info,1)-numh;  %This should be the correct node #
l_info=[Load_Node PL 0];  %Apply horizontal load = PL
%End Input Section
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%Stage 2 Processing/Analysis/Solving, get nodal  & Reactions
solver

%Stage 3 Postprocessing, plot def, stresses, etc
plotter2
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++