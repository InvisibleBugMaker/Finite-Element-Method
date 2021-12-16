%This plots the displaced shape & the three stress contours
%There are so many oter things that could be plotted too, but are not
%included in here. Some examples are: (i) Principal Stresses, 
%(ii) Von Mises stress, (iii) strains (principal, x,y,shear), 
%(iv) displacement contours, 

close all
hold off

%--------------------------------------------------------------------------
%ORIGINAL & DISPLACED SHAPES

%Scale Factor to better show displacement
fdisp=1000;  %Displacement scale factor
uplot=u*fdisp;
for e=1:nume
  %Plot original configuration
  ni=e_info(e,1); nj=e_info(e,2);  nk=e_info(e,3);
  x1=n_info(ni,1); y1=n_info(ni,2);
  x2=n_info(nj,1); y2=n_info(nj,2);
  x3=n_info(nk,1); y3=n_info(nk,2);
  v1x=[x1 x2];  v1y=[y1 y2];  %Vertex 1
  v2x=[x1 x3];  v2y=[y1 y3]; %Vertex 2
  v3x=[x2 x3];  v3y=[y2 y3]; %Vertex 3
  plot(v1x,v1y,'k')
  hold on
  plot(v2x,v2y,'k')
  plot(v3x,v3y,'k')
  
  %Plot Deformed Configuration
  x1=n_info(ni,1)+uplot((ni-1)*2+1); y1=n_info(ni,2)+uplot((ni-1)*2+2);
  x2=n_info(nj,1)+uplot((nj-1)*2+1); y2=n_info(nj,2)+uplot((nj-1)*2+2);
  x3=n_info(nk,1)+uplot((nk-1)*2+1); y3=n_info(nk,2)+uplot((nk-1)*2+2);
  v1x=[x1 x2];  v1y=[y1 y2];  %Vertex 1
  v2x=[x1 x3];  v2y=[y1 y3]; %Vertex 2
  v3x=[x2 x3];  v3y=[y2 y3]; %Vertex 3
  plot(v1x,v1y,'r')
  plot(v2x,v2y,'r')
  plot(v3x,v3y,'r')
end
title('Undeformed (black) & Deformed (red) Shapes')
%END SHAPE PLOTS
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
pause
close all
hold off

%--------------------------------------------------------------------------
%PLOT STRESS CONTOURS. 
%This is a very ugly code. It runs through several times. 
%The first time to find the max & min stresses to set the color code bars. 
%Then it runs again once per stress component to create plots
%There are likely many better ways to do this.

%First run through to find max & min for all stress components
stressmax=[-10^6;-10^6;-10^6]; %Initialize with something very negative
stressmin=[10^6;10^6;10^6]; %Initialize with something very positive
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
  ue=[u(2*(ni-1)+1);u(2*(ni-1)+2);
      u(2*(nj-1)+1);u(2*(nj-1)+2);
      u(2*(nk-1)+1);u(2*(nk-1)+2)];
  stress=C*Be*ue;
  %Update maxes & mins
  if(stress(1)>stressmax(1))
    stressmax(1)=stress(1);
  end
  if(stress(2)>stressmax(2))
    stressmax(2)=stress(2);
    end
  if(stress(3)>stressmax(3))
    stressmax(3)=stress(3);
  end
  if(stress(1)<stressmin(1))
    stressmin(1)=stress(1);
  end
  if(stress(2)<stressmin(2))
    stressmin(2)=stress(2);
    end
  if(stress(3)<stressmin(3))
    stressmin(3)=stress(3);
  end  
end


%Second run through to plot sigma_xx
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
  ue=[u(2*(ni-1)+1);u(2*(ni-1)+2);
      u(2*(nj-1)+1);u(2*(nj-1)+2);
      u(2*(nk-1)+1);u(2*(nk-1)+2)];
  stress=C*Be*ue;
  %Renormaize stresses by maximum absolute value of stress. This is needed
  %to plot (0,1) contour intensity.
  denom=max(max(abs(stressmax(1)),abs(stressmin(1))),max(abs(stressmax(2)),abs(stressmin(2))));
  stressplot=stress(1)/denom; %The exponent should be 1, this looks better for plotting
  xvec=[x1;x2;x3];
  yvec=[y1;y2;y3];
  if(stressplot<0)
    h=fill(xvec,yvec,[0 0 1]);  %Blue for compression
    set(h,'facealpha',-stressplot); %Exponent should be 1, this looks better for plotting
  else
    h=fill(xvec,yvec,[1 0 0]);   %Red for tension
    set(h,'facealpha',stressplot);
  end
  hold on
end
title('Sigma_{xx} Contour (tenson red, compresson blue)')
pause
close all
hold off

%third run through to plot sigma_yy
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
  ue=[u(2*(ni-1)+1);u(2*(ni-1)+2);
      u(2*(nj-1)+1);u(2*(nj-1)+2);
      u(2*(nk-1)+1);u(2*(nk-1)+2)];
  stress=C*Be*ue;
  %Renormaize stresses by maximum absolute value of stress. This is needed
  %to plot (0,1) contour intensity.
  denom=max(max(abs(stressmax(1)),abs(stressmin(1))),max(abs(stressmax(2)),abs(stressmin(2))));
  stressplot=stress(2)/denom;
  xvec=[x1;x2;x3];
  yvec=[y1;y2;y3];
  if(stressplot<0)
    h=fill(xvec,yvec,[0 0 1]);  %Blue for compression
    set(h,'facealpha',-stressplot);
  else
    h=fill(xvec,yvec,[1 0 0]);   %Red for tension
    set(h,'facealpha',stressplot);
  end
  hold on
end
title('Sigma_{yy} Contour (tenson red, compresson blue)')
pause
close all
hold off


%Fourth run through to plot gamma
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
  ue=[u(2*(ni-1)+1);u(2*(ni-1)+2);
      u(2*(nj-1)+1);u(2*(nj-1)+2);
      u(2*(nk-1)+1);u(2*(nk-1)+2)];
  stress=C*Be*ue;
  %Renormaize stresses by maximum absolute value of stress. This is needed
  %to plot (0,1) contour intensity.
  stressplot=stress(3)/max(abs(stressmax(3)),abs(stressmin(3)));
  xvec=[x1;x2;x3];
  yvec=[y1;y2;y3];
  if(stressplot<0)
    h=fill(xvec,yvec,[0 0 1]);  %Blue for compression
    set(h,'facealpha',-stressplot);
  else
    h=fill(xvec,yvec,[1 0 0]);   %Red for tension
    set(h,'facealpha',stressplot);
  end
  hold on
end
title('Tau Contour (positive red, negative blue)')
%END STRESS PLOTS
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

