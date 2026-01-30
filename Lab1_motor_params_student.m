%{  
This script for prepare data and parameters for parameter estimator.
1. Load your collected data to MATLAB workspace.
2. Run this script.
3. Follow parameter estimator instruction.
%}

% R and L from experiment
motor_R = 10.30982581;
motor_L = 35.0259456;
% Optimization's parameters
motor_Eff = 0.96157;
motor_Ke = 0.074986;
motor_J = 1e-09;
motor_B = 1.11e-05;

% Extract collected data
Input = out.data.Data;
Time = out.data.Time;
Velo = double(out.data.Data);

% Plot 
figure(Name='Motor velocity response')
plot(Time,Velo,Time,Input)

