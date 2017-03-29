function [fval] = Composite_Optimization()
clear;
clc;

Sx=1.81297e8; %Recorded Stress from fintie element analysis
Sy=6.31642e8;
Gamma_xy=2.64260e7;


LB = [1]; %Miniumum number of plys
UB = [200];%Maximum numbe of plys

options=gaoptimset('populationsize',20,'generations',15,'display','iter','tolfun',1e-999,'tolcon',1e-999,'useparallel', 'always','plotfcns', {@gaplotbestf,@gaplotmaxconstr,@gaplotscorediversity,@gaplotscores});
[n,fval] = ga(@objectivefcn,length(LB),[],[],[],[],LB,UB,[],options);
%%
    function [f,NormX_max] = objectivefcn(n)
        
        n=floor(n);
        Norm_max = Qij_Calc(n)*-1;
        S = Sx+Sy+Gamma_xy;
        if Norm_max <= S %conditional statment that ensures all ply configurations pass min stress requirments
            f=199;
        else
            f=n;
        end
        clc;
        fid = fopen('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\No_plys.txt', 'w');
        fprintf(fid,'\n%d\n',f);
        fclose(fid);
    end


open('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\No_plys.txt');
open('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\Orientation.txt');
open('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\Maximized_Force.txt');
open('D:\Users\Jeff\Documents\School Documents\Graduate - Mechanical\Composites\Project\Optimization Code\Maximized_Moments.txt');

end
