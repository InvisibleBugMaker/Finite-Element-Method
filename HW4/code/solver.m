%Solver, Do not edit this code, should work for all triangular element
%meshes
G=E/(2*(1+nu)); %a derived unit, don't need to directly define this

%Define [C] matrix, check whether user wanted PStress or PStrain
if(type==0)
  C=[E/(1-nu^2) E*nu/(1-nu^2) 0;
     E*nu/(1-nu^2) E/(1-nu^2) 0;
     0 0 G];  
else
  C=[(1-nu)*E/((1+nu)*(1-2*nu)) nu*E/((1+nu)*(1-2*nu)) 0;
     nu*E/((1+nu)*(1-2*nu)) (1-nu)*E/((1+nu)*(1-2*nu)) 0;
     0 0 G];  
end

%Assemble Global Stiffness Matrix
numn=size(n_info,1);
nume=size(e_info,1);
K=zeros(numn*2,numn*2); %initialize global K, 2dofs per node.
for e=1:nume
  %Calculate Ke
  ni=e_info(e,1); nj=e_info(e,2);  nk=e_info(e,3);
  x1=n_info(ni,1); y1=n_info(ni,2);
  x2=n_info(nj,1); y2=n_info(nj,2);
  x3=n_info(nk,1); y3=n_info(nk,2); 
  d=x3*y1-x2*y1+x1*y2-x3*y2-x1*y3+x2*y3;
  a1=(y2-y3)/d;  b1=(x3-x2)/d;   %Note, don't need ci
  a2=(y3-y1)/d;  b2=(x1-x3)/d;
  a3=(y1-y2)/d;  b3=(x2-x1)/d;
  Ae=1/2*abs((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1));
  Be=[a1 0  a2 0  a3 0;
      0  b1 0  b2 0  b3;
      b1 a1 b2 a2 b3 a3];
  Ke=Ae*Be'*C*Be;
  %Place Ke in the proper locations in K. 
  %Get all 9 2x2s. Note, they are 2x2s as 2DOFs per node
  Keii=Ke(1:2,1:2);  Keij=Ke(1:2,3:4);  Keik=Ke(1:2,5:6);
  Keji=Ke(3:4,1:2);  Kejj=Ke(3:4,3:4);  Kejk=Ke(3:4,5:6);
  Keki=Ke(5:6,1:2);  Kekj=Ke(5:6,3:4);  Kekk=Ke(5:6,5:6);
  %Get the global node numbers associated with i,j,k; Below the G->global
  iG=(ni-1)*2+1:(ni-1)*2+2; 
  jG=(nj-1)*2+1:(nj-1)*2+2; 
  kG=(nk-1)*2+1:(nk-1)*2+2;
  %Put the local 2x2s in the proper global 2x2 locations
  K(iG,iG)=K(iG,iG)+Keii; K(iG,jG)=K(iG,jG)+Keij; K(iG,kG)=K(iG,kG)+Keik;
  K(jG,iG)=K(jG,iG)+Keji; K(jG,jG)=K(jG,jG)+Kejj; K(jG,kG)=K(jG,kG)+Kejk;
  K(kG,iG)=K(kG,iG)+Keki; K(kG,jG)=K(kG,jG)+Kekj; K(kG,kG)=K(kG,kG)+Kekk;
end

%Assemble Load Vector
numl=size(l_info,1);
p=zeros(numn*2,1);
for il=1:numl
  ni=l_info(il,1);
  iG=(ni-1)*2+1:(ni-1)*2+2;
  p(iG)=p(iG)+l_info(il,2:3)';
end

%Apply BCs. This thing goes through each node and puts their two dofs into
%either idf or ids depending on whether the dof is fixed or free.
idf=0; %Will have to remove this afterward. Need to initialize here.
ids=0; 
for iBC=1:numn
  iGx=(iBC-1)*2+1;
  if(n_info(iBC,3)==0)
    idf=[idf;iGx];
  else
    ids=[ids;iGx];
  end
  iGy=iGx+1;
  if(n_info(iBC,4)==0)
    idf=[idf;iGy];
  else
    ids=[ids;iGy];
  end
end
idf(1)=[]; %Remove the initialization first entry
ids(1)=[];
Kff=K(idf,idf);
Kfs=K(idf,ids);
Ksf=K(ids,idf);
Kss=K(ids,ids);

%Find support settlement vector;
us=zeros(numn*2,1);
for iBC=1:numn
  iGx=(iBC-1)*2+1;
  iGy=iGx+1;
  us(iGx:iGy)=us(iGx:iGy)+n_info(iBC,5:6)';
end
us(idf)=[]; %This is the displacements of the supports;

%Partition load vector
pf=p(idf);

%Solve the free displacements
uf=inv(Kff)*(pf-Kfs*us);

%Solve Reactions
ps=Ksf*uf+Kss*us;

%Reassemble overall displacement and force vectors;
u=zeros(numn*2,1);
p(ids)=ps;
P(idf)=pf;
u(ids)=us;
u(idf)=uf;

%Check global equilibrium in x and y directions
SumFx=sum(p(1:2:numn*2));
SumFy=sum(p(2:2:numn*2));
