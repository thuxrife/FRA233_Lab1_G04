%{  
This script for prepare data and parameters for parameter estimator.
1. Load your collected data to MATLAB workspace.
2. Run this script.
3. Follow parameter estimator instruction.
%}

% R and L from experiment
motor_R = 1.00;
motor_L = 0.01;
% Optimization's parameters
motor_Eff = 0.5;
motor_Ke = 0.05;
motor_J = 0.001;
motor_B = 0.0001;

% Extract collected data
Input = data{1}.Values.Data;
Time = data{1}.Values.Time;
Velo = double(data{2}.Values.Data);

% Plot 
figure(Name='Motor velocity response')
plot(Time,Velo,Time,Input)

