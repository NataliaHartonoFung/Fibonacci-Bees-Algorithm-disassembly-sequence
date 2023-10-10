%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Fibonacci Bees Algorithm for Robotic Disassembly Sequence Problem    %
%   Natalia Hartono and Duc Truong Pham                                  %
%   This code accompanied the paper: A Novel Fibonacci-inspired          %
%   enhancement                                                          %
%   of the Bees Algorithm: Application to Robotic Disassembly Sequence   %
%   Planning                                                             %
%                                                                        %
%   This BAF code was build upon the code from this paper:               %
%   https://doi.org/10.1080/00207543.2017.1412527                        %
%   Robotic disassembly sequence planning using enhanced discrete bees   %
%   algorithm in remanufacturing, International Journal of Production    %
%   Research, Volume 56, 2018, issue 9.                                  %
%   Jiayi Liu, Zude Zhou, Duc Truong Pham, Wenjun Xu, Chuqian Ji,        %
%   Quan Liu.                                                            %
%                                                                        %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Do not change this part
clc;
clear;
close all;

load inputdataGearA.mat      %Gear pump A input data
%load inputdataGearB.mat     %Gear pump B input data

S = [sum(Direction_Y_plus,2),sum(Direction_Y_minus,2)];
width = length(Direction_Y_minus);
speed = 12;
timescale = 2;

%% Runtimes can be change according to user preference
runtimes = 5;

%% Bees Algorithm Parameters 
%% The paramater can be changed, but please refer to the paper for guidance
nSelectedSite=4;    % Number of Selected Sites (can be changed)
nrpersite = [13,8,5,3];  %21,13,8,5,3,2,1,1 (can be changed) %recruitement nr per site
counter = 0;

for nScoutBee = 26        %can be changed
    for MaxIt =100            %can be changed
        for run = 1:runtimes
            BAFrun;
            Objective(run) = OptCost(it); 
            NFE(run)=counter;  %this is to calculate number function of evaluation
        end
        name = ['Result_',num2str(MaxIt),'pop',num2str(nScoutBee)];
        ave_Objective = sum(Objective(1:runtimes))/runtimes;
        ave_NFE = NFE(run)/runtimes;
        standardev = std(Objective(1:runtimes));
        save(name,'Objective','ave_Objective','BestSol','ave_NFE','standardev');  
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How to read the output:                                                 %
% BestSol = the output of robotic disassembly sequence, direction, tool,  %
%           direction change, toolchange, distance, totalcost (objective) %
% Objective = the best objective results recorded in each runs            %
% ave_NFE = average Number of Function of Evaluation                      %
% ave_Objective = average of the objective                                %
% standardev = standar deviation                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
