function [fval] = Qij_Calc (n)
%%%% - make sure that the Normx value is that which corresponds to the n
%%%% ply value and nothing else
%clc

%n=5;

for Low=1:n; %Lower bound that is dependent on the number of plys issued by GA in Composite_Optimization script
    LowB(1,Low)=-90;%min ply angle is -90 degrees
end



for High=1:n; %upper bound that is dependent on the number of plys issued by GA in Composite_Optimization script
    UpB(1,High)=90;%max ply angle is 90 deg
end

LB=LowB;
UB=UpB;
%%
options=gaoptimset('PopulationSize',30,'Generations',20);
[x,fval,population,scores] = ga(@Objectivefcn,n,[],[],[],[],LB,UB,[],options);

    function [fval] = Objectivefcn(x)
        
        x=-x*100;
%         for j=1:n
%             if x(j)>90
%                 x(j)=90
%             else if x(j)>=67.5
%                     x(j)=90;
%                 else if x(j)>=22.5
%                         x(j)=45;
%                     else if x(j)< 22.5
%                             x(j)=0;
%                         else if x(j)<=-22.5
%                                 x(j)=-45;
%                             else if x(j)<=-67.5
%                                     x(j)=-90;
%                                 else x(j)<-90
%                                     x(j)=-90;
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
        
        
        NormF = Force(x,n);
        %pause(1)
        NormX = NormF(1);
        %pause(1)
        NormY = NormF(2);
        %pause(1)
        Shear = NormF(3);
        %pause(1)
        fval=-1*(NormX+NormY+Shear);
        %clc;
        NormFo = [NormF(1);NormF(2);NormF(3)];
        Momn = [NormF(4);NormF(5);NormF(6)];
        fid = fopen('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\Orientation.txt', 'w');
        fprintf(fid,'\n%d\n',x);
        fclose(fid);
        fid = fopen('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\Maximized_Force.txt', 'w');
        fprintf(fid,'\n%s\n',NormFo);
        fclose(fid);
         fid = fopen('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\Maximized_Moments.txt', 'w');
        fprintf(fid,'\n%s\n',Momn);
        fclose(fid);
        
        clc;
    end
x;
fval;
population;
scores;

end