function [Nn] = Force (x,n)

%clc
%n=3;
%x=[90 45 75];

EL = 8e10; %Longitudinal Elastic modulus
ET = 6.5e9; %Tansverse Elastic Modulus
GLT = 5.35e9; %Shear Modulus
vlt=0.022; %Major possions ratio
vtl=0.3125; %Minor Possions ratio

Eps = [1.60308e-2;1.62277e-2;0;0;0;0.0052023]; %Strain of middle plane
K=[0.3104;0;0;0;0;0]; %plate curvatures

h=0.003; %height of the plys

q11 = EL/(1-vlt*vtl);
%pause(1)
q22 = ET/(1-vlt*vtl);
%pause(1)
q12 = (vlt*ET)/(1-vlt*vtl);
%pause(1)
q66 = GLT;
%pause(1)

U1=1/8*(3*q11+3*q22+2*q12+4*q66);
%pause(1)
U2=1/2*(q11-q22);
%pause(1)
U3=1/8*(q11+q22-2*q12-4*q66);
%pause(1)
U4=1/8*(q11+q22+6*q12-4*q66);
%pause(1)
U5=1/2*(U1-U4);
%pause(1)

for i=1:6;
    for j=1:6;
        A(i,j)=0;
    end
end

for i=1:6;
    for j=1:6;
        B(i,j)=0;
    end
end

for i=1:6;
    for j=1:6;
        D(i,j)=0;
    end
end

for iter = 1:n;
    for fi=1:6;
        for sec=1:6;
            Q(fi,sec)=0;
        end
    end
    Q(1,1)=U1+U2*cosd(2*x(iter))+U3*cosd(4*x(iter));
    Q(1,2)=U4-U3*cosd(4*x(iter));
    Q(2,1)=Q(1,2);
    Q(1,6)=1/2*U2*sind(2*x(iter))+U3*sind(4*x(iter));
    Q(2,2)=U1-U2*cosd(2*x(iter))+U3*cosd(4*x(iter));
    Q(2,6)=1/2*U2*sind(2*x(iter))-U3*sind(4*x(iter));
    Q(6,1)=Q(1,6);
    Q(6,2)=Q(2,6);
    Q(6,6) =U5-U3*cosd(4*x(iter));
    
    for i=1:6;
        for j=1:6;
            for k=1:n;
                A(i,j)=Q(i,j)*h+A(i,j);
                B(i,j)=1/2*Q(i,j)*h+B(i,j);
                D(i,j)=1/3*Q(i,j)*h+D(i,j);
            end
        end
    end
end
A;


%pause(1)
B;
%pause(1)
D;
%pause(1)

N = A*Eps+B*K; %Resultant force
%pause(2)
M = B*Eps+D*K; %Resultant moments
%pause(2)

NormX=N(1);%Resultant force in the x direction
NormY=N(2);%Resultant force in the x direction
Shear=N(6);%Shear componet
%pause(2)
Nn=[N(1);N(2);N(6);M(1);M(2);M(6)];
end