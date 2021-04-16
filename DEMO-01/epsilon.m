%% Demo: How to find the machine epsilon
% Also an example how to write the code to be PUBLISH'ed.

% Always start a script with these three:

clear all     % Clear memory
close all     % Deletes all old figures
clc           % Clear the command window

eps     % Print out the default value

%% Double precision:
eps=1;
while (eps+1>1)
    eps=eps/2;
end
eps*2

%% Single precision:
eps=single(1);   
while (eps+1>1)
    eps=eps/2;
end
eps*2
