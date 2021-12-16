clc
clear all
close all

% NOTE: YOU WILL HAVE TO EDIT THE FUNCTION getArea.m                      %                       %  %
%  TO ENSURE THAT THE A(x) FUNCTION MATCHES WHAT IS SPECIFIED IN PROBLEM 4    %     

leg={'Exact'};
flag=1;
%BEGIN _____________________________ u s e r    i n p u t s_______________________________________%  %
																								  %  %
																								  %  %
A0=4; %in^2 <- area at LHS of rod                                                                 %  %
																								  %  %
A1=2; %in^2 <- area at RHS of rod                                                                 %  %
																								  %  %
L=24;      %m                                                                                      %  %
E=10000000;  %Pa                                                                                     %  %
																								  %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
%%%%%%%%% nodal information matrix %%%%%%%%%                                                      %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
        % x location | fixity (1=fixed, 0=free)                                                   %  %
n_info=     [0          1;
            L/2         0;%  %
            L         0];                                                                       %  %
%  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
%%%%%%%%% element information matrix %%%%%%%%%                                                    %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
        % i node, j node, E                                                                       %  %
e_info=[1,     2,     E; 
        2,     3,     E];                                                                         %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
numelem=size(e_info,1);  %number of elements                                                      %  %
																								  %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
%%%%%%%%%%%%%%%% LOADING %%%%%%%%%%%%%%%%%%%                                                      %  %
P=100;    %Applied Load                                                                         %  %
b=0; %m/s^2                                                                                       %  %
																								  %  %
P_loaded_Node=numelem+1; %<- in this case, the point load is applied at the end of the rod        %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                  %  %
%%%%% EXACT SOLUTION for displacement (used for plotting) %%%%%%                                  %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                  %  %
syms u(x) x                                                                                       %  %
% u(x)=?; %<- exact solution (Change this using your acquired solution to problem 2a)             %  %
																								  %  %
u(x)=(P*L/(E*(A0*(A1-A0))^0.5))*atan((x/L)*(1/sqrt(A0))*sqrt(A1-A0))  %(exact soln - problem 4)   %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      %  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %  %
%END _______________________________ u s e r    i n p u t s_______________________________________%  %



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DO NOT MODIFY BELOW, UNLESS YOU ARE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BRAVE/HAVE A COPY OF ORIGINAL SAVED


nnodes=numelem+1;     %number of nodes in the linear element system 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555

% initializing arrays for Stiffness Matrix and FVector = fixed end forces + applied loads

Kglob=zeros(nnodes,nnodes);
Fglob=zeros(nnodes,1);
uFE_soln=zeros(length(Fglob),1);

endNodesLocList=[]; %< used for plotting only
for i=1:size(e_info,1);
    
    currentElemCenterXloc=(n_info(e_info(i,1),1) + n_info(e_info(i,2),1))/2; %element center=(x location of i node + x location of j node)/2 
    
    L_elem(i)=(n_info(e_info(i,2),1)-n_info(e_info(i,1),1)); %<- determining the length of the current element
    
    getArea %< getting element x-sec area by calling subroutine (EDIT THIS FOR NONPRISMATIC SECTION)
    
    Ke    %< getting element stiffness by calling subroutine (also included at end as a comment)
    KeLinear1DRoddivA(i,:,:)=KeLinear1DRod./ElA;
    % Global Stiffness Matrix assembly
    curr_doflist=[e_info(i,1),e_info(i,2)];
    Fe=[(b*L_elem/2);(b*L_elem/2)];
    for j=1:length(curr_doflist);
        for jj=1:length(curr_doflist);
        Kglob(curr_doflist(j),curr_doflist(jj))=Kglob(curr_doflist(j),curr_doflist(jj))+KeLinear1DRod(j,jj);
        end
        Fglob(curr_doflist(j))=Fglob(curr_doflist(j)) + Fe(j);
    end
    
    
    
    
 
    endNodesLocList=[endNodesLocList,n_info(e_info(i,1),1),n_info(e_info(i,2),1)];  %< used for plotting only
end


xExact=L.*[1:100]./100;
uExact=u(xExact); %<- exact solution for the displacement
du=symfun(diff(u(x),x),x);
sExact=E*du(xExact);

constlin=find(n_info(:,2));

Kglob(constlin,:)=[];
Kglob(:,constlin)=[];

Fglob(P_loaded_Node)=Fglob(P_loaded_Node)+P;

Fglob(constlin,:)=[];

ulin=Kglob\Fglob; %<- solving the system of equations

uFE_soln(setdiff(1:end,constlin),:)=ulin;
eFE_soln=uFE_soln./L_elem;
for ijk=1:numelem;
    jkl=ijk+1;
Stress_FE(ijk,:)=abs(reshape(KeLinear1DRoddivA(ijk,:,:),[2 2])*(uFE_soln(jkl-1:jkl)-uFE_soln(jkl-1)));
end
Stress_FE=reshape(Stress_FE',[numelem*2,1]);


if flag==1;
figure;
subplot(2,1,1)
hold on;
plot(xExact,uExact,'k');
plot(n_info(:,1),uFE_soln,['-.or']);
leg(:,end+1)={string(size(e_info,1))+' Elements'};
xlabel('X Position')
ylabel('Displacement');

subplot(2,1,2)
hold on;
plot(xExact,sExact,'k');
plot(endNodesLocList,Stress_FE,['-.or']);
xlabel('X Position')
ylabel('Stress');
flag=0;
else
subplot(2,1,1)
hold on;
plot(n_info(:,1),uFE_soln,['-.or']);
leg(:,end+1)={string(size(e_info,1))+' Elements'};

subplot(2,1,2)
hold on;
plot(endNodesLocList,Stress_FE,['-.or']);
end


subplot(2,1,1)
legend(leg)
subplot(2,1,2)
legend(leg)