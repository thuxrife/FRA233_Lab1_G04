%{  
This script for prepare data and parameters for parameter estimator.
1. Load your collected data to MATLAB workspace.
2. Run this script.
3. Follow parameter estimator instruction.
%}

% R and L from experiment
motor_R = 3.399924458;
motor_L = 0.002853248;
% Optimization's parameters
motor_Eff = 1.0;
motor_Ke = 0.05;
motor_J = 1e-04;
motor_B = 1e-04;

fprintf('Motor parameters loaded. You can now run Simulink.\n');