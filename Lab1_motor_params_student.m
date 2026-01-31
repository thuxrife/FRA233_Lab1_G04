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
motor_J = 0.001;
motor_B = 0.0001;

fprintf('Motor parameters loaded. You can now run Simulink.\n');